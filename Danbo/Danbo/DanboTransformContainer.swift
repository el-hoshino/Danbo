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
	
	fileprivate func apply(_ parameter: AffineTransformParameter) {
		
		switch parameter {
		case .to(let transform):
			self.body.transform = transform
			
		case .by(let transform):
			self.body.transform *= transform
		}
		
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
	
	public func translate(by vector: CGVector) -> DanboTransformContainer {
		
		let transform = CGAffineTransform(translationX: vector.dx, y: vector.dy)
		let danbo = self.adding(transform)
		return danbo
		
	}
	
	public func scale(by vector: CGVector) -> DanboTransformContainer {
		
		let transform = CGAffineTransform(scaleX: vector.dx, y: vector.dy)
		let danbo = self.adding(transform)
		return danbo
		
	}
	
	public func rotate(by angle: CGFloat) -> DanboTransformContainer {
		
		let transform = CGAffineTransform(rotationAngle: angle)
		let danbo = self.adding(transform)
		return danbo
		
	}
	
}

extension DanboTransformContainer {
	
	public func commit() {
		
		self.parameterArray.forEach { (parameter) in
			self.apply(parameter)
		}
		
	}
	
}
