//
//  DanboTransformContainer.swift
//  Danbo
//
//  Created by 史翔新 on 2017/05/12.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

public struct DanboTransformContainer<Containee: DanboCompatible> {
	
	private var parameterArray: [AffineTransformParameter]
	private let body: Containee
	
}

extension DanboTransformContainer {
	
	public enum Finished {
		case success
	}
	
}

extension DanboTransformContainer {
	
	init(_ body: Containee) {
		self.parameterArray = []
		self.body = body
	}
	
}

extension DanboTransformContainer where Containee: UIView {
	
	private func setting(to transform: CGAffineTransform) -> DanboTransformContainer {
		
		var danbo = self
		let parameter = AffineTransformParameter.to(transform)
		danbo.parameterArray = [parameter]
		
		return danbo
		
	}
	
	private func adding(_ transform: CGAffineTransform) -> DanboTransformContainer {
		
		var danbo = self
		let parameter = AffineTransformParameter.by(transform)
		danbo.parameterArray.append(parameter)
		
		return danbo
		
	}
	
}

extension DanboTransformContainer where Containee: UIView {
	
	public func reset() -> DanboTransformContainer {
		
		let transform = CGAffineTransform.identity
		let danbo = self.setting(to: transform)
		return danbo
		
	}
	
}

extension DanboTransformContainer where Containee: UIView {
	
	public func translate(by translation: Translation) -> DanboTransformContainer {
		
		let transform = CGAffineTransform(translationX: translation.dx, y: translation.dy)
		let danbo = self.adding(transform)
		return danbo
		
	}
	
	public func translateBy(dx: CGFloat, dy: CGFloat) -> DanboTransformContainer {
		
		let translation = Translation(dx: dx, dy: dy)
		return self.translate(by: translation)
		
	}
	
	public func translateBy(dx: CGFloat) -> DanboTransformContainer {
		
		return self.translateBy(dx: dx, dy: 0)
		
	}
	
	public func translateBy(dy: CGFloat) -> DanboTransformContainer {
		
		return self.translateBy(dx: 0, dy: dy)
		
	}
	
}

extension DanboTransformContainer where Containee: UIView {
	
	public func scale(by scale: Scale) -> DanboTransformContainer {
		
		let transform = CGAffineTransform(scaleX: scale.dx, y: scale.dy)
		let danbo = self.adding(transform)
		return danbo
		
	}
	
	public func scale(by scale: CGFloat) -> DanboTransformContainer {
		
		let transform = CGAffineTransform(scaleX: scale, y: scale)
		let danbo = self.adding(transform)
		return danbo
		
	}
	
	public func scaleBy(dx: CGFloat, dy: CGFloat) -> DanboTransformContainer {
		
		let scale = Scale(dx: dx, dy: dy)
		return self.scale(by: scale)
		
	}
	
	public func scaleBy(dx: CGFloat) -> DanboTransformContainer {
		
		return self.scaleBy(dx: dx, dy: 1)
		
	}
	
	public func scaleBy(dy: CGFloat) -> DanboTransformContainer {
		
		return self.scaleBy(dx: 1, dy: dy)
		
	}
	
}

extension DanboTransformContainer where Containee: UIView {
	
	public func rotate(by rotation: Rotation) -> DanboTransformContainer {
		
		let transform = CGAffineTransform(rotationAngle: rotation.angle)
		let danbo = self.adding(transform)
		return danbo
		
	}
	
	public func rotateBy(radian radianValue: CGFloat) -> DanboTransformContainer {
		
		let rotation = Rotation.radian(radianValue)
		return self.rotate(by: rotation)
		
	}
	
	public func rotateBy(degree degreeValue: CGFloat) -> DanboTransformContainer {
		
		let rotation = Rotation.degree(degreeValue)
		return self.rotate(by: rotation)
		
	}
	
}

extension DanboTransformContainer where Containee: UIView {
	
	func commit() -> Finished {
		
		let transform = self.parameterArray.reduce(self.body.transform) { (transform, nextParameter) -> CGAffineTransform in
			return transform.applying(nextParameter)
		}
		
		self.body.transform = transform
		
		return .success
		
	}
	
}
