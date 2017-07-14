//
//  DanboSettingContainer.swift
//  Danbo
//
//  Created by 史　翔新 on 2017/07/14.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

public struct DanboSettingContainer<Containee: DanboCompatible> {
	
	private var anchor: ((DanboAnchorContainer<Containee>) -> DanboAnchorContainer<Containee>.Finished)?
	private var transform: ((DanboTransformContainer<Containee>) -> DanboTransformContainer<Containee>)?
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
	
	public func setAnchor(to anchor: @escaping (DanboAnchorContainer<Containee>) -> DanboAnchorContainer<Containee>.Finished) -> DanboSettingContainer {
		
		var danbo = self
		danbo.anchor = anchor
		
		return danbo
		
	}
	
}

extension DanboSettingContainer where Containee: UIView {
	
	public func setTransform(to transform: @escaping (DanboTransformContainer<Containee>) -> DanboTransformContainer<Containee>) -> DanboSettingContainer {
		
		var danbo = self
		danbo.transform = transform
		
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
		
		let anchorContainer = DanboAnchorContainer(self.body)
		let result = anchor(anchorContainer)
		
		switch result {
		case .success:
			return .success
		}
		
	}
	
	private func setTransform() -> Finished {
		
		guard let transform = self.transform else {
			return .success
		}
		
		let transformContainer = DanboTransformContainer(self.body)
		let result = transform(transformContainer).commit()
		
		switch result {
		case .success:
			return .success
		}
		
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
