//
//  Rotation.swift
//  Danbo
//
//  Created by 史翔新 on 2017/05/12.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

public struct Rotation {
	
	public var angle: CGFloat
	
	public init(angle: CGFloat) {
		self.angle = angle
	}
	
}

extension Rotation {
	
	public static func radian(_ value: CGFloat) -> Rotation {
		return Rotation(angle: value)
	}
	
	public static func degree(_ value: CGFloat) -> Rotation {
		return Rotation(angle: value.radianValue)
	}
	
}

extension Rotation {
	
	public static let zero: Rotation = .radian(0)
	
}

extension Rotation: ExpressibleByIntegerLiteral {
	
	public typealias IntegerLiteralType = Int
	
	public init(integerLiteral value: IntegerLiteralType) {
		self.angle = CGFloat(value)
	}
	
}

extension Rotation: ExpressibleByFloatLiteral {
	
	public typealias FloatLiteralType = Double
	
	public init(floatLiteral value: FloatLiteralType) {
		self.angle = CGFloat(value)
	}
	
}

extension Rotation {
	
	public var radianValue: CGFloat {
		
		return self.angle
		
	}
	
	public var degreeValue: CGFloat {
		
		return self.angle.degreeValue
		
	}
	
}

extension Rotation {
	
	public static prefix func - (x: Rotation) -> Rotation {
		
		return .init(angle: -x.angle)
		
	}
	
}

private extension CGFloat {
	
	var radianValue: CGFloat {
		
		return self / 180 * .pi
		
	}
	
	var degreeValue: CGFloat {
		
		return self * .pi / 180
		
	}
	
}

public func sin(_ x: Rotation) -> CGFloat {
	return sin(x.angle)
}

public func cos(_ x: Rotation) -> CGFloat {
	return cos(x.angle)
}

public func tan(_ x: Rotation) -> CGFloat {
	return tan(x.angle)
}

public func cot(_ x: Rotation) -> CGFloat {
	return cot(x.angle)
}
