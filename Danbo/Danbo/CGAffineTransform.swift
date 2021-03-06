//
//  CGAffineTransform.swift
//  Danbo
//
//  Created by 史　翔新 on 2017/05/10.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

extension CGAffineTransform {
	
	public static func * (lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
		return lhs.concatenating(rhs)
	}
	
	public static func *= (lhs: inout CGAffineTransform, rhs: CGAffineTransform) {
		lhs = lhs * rhs
	}
	
	public static func / (lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
		return lhs.concatenating(rhs.inverted())
	}
	
	public static func /= (lhs: inout CGAffineTransform, rhs: CGAffineTransform) {
		lhs = lhs / rhs
	}
	
	public static func == (lhs: CGAffineTransform, rhs: CGAffineTransform) -> Bool {
		return lhs.__equalTo(rhs)
	}
	
}

extension CGAffineTransform {
	
	public func translate(by translation: Translation) -> CGAffineTransform {
		return self.translatedBy(x: translation.dx, y: translation.dy)
	}
	
}

extension CGAffineTransform {
	
	public mutating func translateBy(x: CGFloat, y: CGFloat) {
		self = self.translatedBy(x: x, y: y)
	}
	
	public mutating func scaleBy(x: CGFloat, y: CGFloat) {
		self = self.scaledBy(x: x, y: y)
	}
	
	public mutating func rotate(by angle: CGFloat) {
		self = self.rotated(by: angle)
	}
	
	public mutating func invert() {
		self = self.inverted()
	}
	
}

extension CGAffineTransform {
	
	func applying(_ parameter: AffineTransformParameter) -> CGAffineTransform {
		
		switch parameter {
		case .to(let transform):
			return transform
			
		case .by(let transform):
			return self * transform
		}
		
	}
	
}
