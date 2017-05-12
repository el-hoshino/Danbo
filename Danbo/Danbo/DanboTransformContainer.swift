//
//  DanboTransformContainer.swift
//  Danbo
//
//  Created by 史翔新 on 2017/05/12.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

public struct DanboTransformContainer {
	
	fileprivate var parameterArray: [AffineTransformParameter]
	
	fileprivate var body: DanboCompatible
	
}

extension DanboTransformContainer {
	
	init(body: DanboCompatible) {
		self.parameterArray = []
		self.body = body
	}
	
}

extension DanboTransformContainer {
	
	fileprivate func setting(to transform: CGAffineTransform) -> DanboTransformContainer {
		
		let parameter = AffineTransformParameter.to(transform)
		let newParameterArray = [parameter]
		let danbo = DanboTransformContainer(parameterArray: newParameterArray, body: self.body)
		return danbo
		
	}
	
	fileprivate func adding(_ transform: CGAffineTransform) -> DanboTransformContainer {
		
		let parameter = AffineTransformParameter.by(transform)
		let newParameterArray = self.parameterArray + [parameter]
		let danbo = DanboTransformContainer(parameterArray: newParameterArray, body: self.body)
		return danbo
		
	}
	
}

extension DanboTransformContainer {
	
	public func reset() -> DanboTransformContainer {
		
		let transform = CGAffineTransform.identity
		let danbo = self.setting(to: transform)
		return danbo
		
	}
	
}

extension DanboTransformContainer {
	
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

extension DanboTransformContainer {
	
	public func scale(by scale: Scale) -> DanboTransformContainer {
		
		let transform = CGAffineTransform(scaleX: scale.dx, y: scale.dy)
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

extension DanboTransformContainer {
	
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

extension DanboTransformContainer {
	
	public func commit() {
		
		let transform = self.parameterArray.reduce(self.body.transform) { (transform, nextParameter) -> CGAffineTransform in
			return transform.applying(nextParameter)
		}
		
		self.body.transform = transform
		
	}
	
}
