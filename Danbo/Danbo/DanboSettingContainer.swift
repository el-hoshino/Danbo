//
//  DanboSettingContainer.swift
//  Danbo
//
//  Created by 史　翔新 on 2017/07/14.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

public struct DanboSettingContainer<Containee: DanboCompatible> {
	
	private enum Setting<RawValue, ClosureValue> {
		case raw(RawValue)
		case closure(ClosureValue)
	}
	
	private typealias AnchorSetting = Setting<CGPoint, (DanboAnchorContainer<Containee>) -> DanboAnchorContainer<Containee>.Finished>
	
	private typealias TransformSetting = Setting<CGAffineTransform, (DanboTransformContainer<Containee>) -> DanboTransformContainer<Containee>>
	
	private var anchor: AnchorSetting?
	private var transform: TransformSetting?
	private var alpha: [SettingParameter.Alpha]
	
	private let body: Containee
	
}

extension DanboSettingContainer {
	
	public enum Finished {
		case success
	}
	
}

extension DanboSettingContainer {
	
	init(_ body: Containee) {
		self.alpha = []
		self.body = body
	}
	
}

extension DanboSettingContainer where Containee: UIView {
	
	public func setAnchor(to anchor: CGPoint) -> DanboSettingContainer {
		
		var danbo = self
		danbo.anchor = AnchorSetting.raw(anchor)
		
		return danbo
		
	}
	
	public func setAnchor(by setting: @escaping (DanboAnchorContainer<Containee>) -> DanboAnchorContainer<Containee>.Finished) -> DanboSettingContainer {
		
		var danbo = self
		danbo.anchor = AnchorSetting.closure(setting)
		
		return danbo
		
	}
	
}

extension DanboSettingContainer where Containee: UIView {
	
	public func setTransform(to transform: CGAffineTransform) -> DanboSettingContainer {
		
		var danbo = self
		danbo.transform = TransformSetting.raw(transform)
		
		return danbo
		
	}
	
	public func setTransform(by setting: @escaping (DanboTransformContainer<Containee>) -> DanboTransformContainer<Containee>) -> DanboSettingContainer {
		
		var danbo = self
		danbo.transform = TransformSetting.closure(setting)
		
		return danbo
		
	}
	
}

extension DanboSettingContainer where Containee: UIView {
	
	public func setAlpha(to goal: CGFloat) -> DanboSettingContainer {
		
		var container = self
		container.alpha = [.to(goal)]
		
		return container
		
	}
	
	public func addAlpha(by diff: CGFloat) -> DanboSettingContainer {
		
		var container = self
		container.alpha.append(.by(diff))
		
		return container
		
	}
	
}

extension DanboSettingContainer where Containee: UIView {
	
	private func setAnchor() -> Finished {
		
		guard let anchor = self.anchor else {
			return .success
		}
		
		let result: Finished
		
		switch anchor {
		case .raw(let value):
			self.body.layer.anchorPoint = value
			result = .success
			
		case .closure(let setting):
			let container = DanboAnchorContainer(self.body)
			let anchorResult = setting(container)
			
			switch anchorResult {
			case .success:
				result = .success
			}
			
		}
		
		return result
		
	}
	
	private func setTransform() -> Finished {
		
		guard let transform = self.transform else {
			return .success
		}
		
		let result: Finished
		
		switch transform {
		case .raw(let value):
			self.body.transform = value
			result = .success
			
		case .closure(let setting):
			let container = DanboTransformContainer(self.body)
			let transformResult = setting(container).commit()
			
			switch transformResult {
			case .success:
				result = .success
			}
			
		}
		
		return result
		
	}
	
	private func setAlpha() -> Finished {
		
		guard self.alpha.isEmpty == false else {
			return .success
		}
		
		var targetAlpha = self.body.alpha
		
		for alpha in self.alpha {
			switch alpha {
			case .to(let goal):
				targetAlpha = goal
				
			case .by(let diff):
				targetAlpha += diff
			}
		}
		
		self.body.alpha = targetAlpha
		
		return .success
		
	}
	
	public func commit() -> Finished {
		
		var results: [Finished] = []
		
		do {
			let result = self.setAnchor()
			results.append(result)
		}
		
		do {
			let result = self.setTransform()
			results.append(result)
		}
		
		do {
			let result = self.setAlpha()
			results.append(result)
		}
		
		let result = results.reduce(.success) { (reduced, result) -> Finished in
			return reduced & result
		}
		
		return result
		
	}
	
}

extension DanboSettingContainer.Finished {
	
	fileprivate static func & (lhs: DanboSettingContainer.Finished, rhs: DanboSettingContainer.Finished) -> DanboSettingContainer.Finished {
		
		switch (lhs, rhs) {
		case (.success, .success):
			return .success
		}
		
	}
	
}
