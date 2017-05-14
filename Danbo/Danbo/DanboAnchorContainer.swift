//
//  DanboAnchorContainer.swift
//  Danbo
//
//  Created by 史翔新 on 2017/05/13.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

public protocol DanboAnchorCompatible: class {
	
	var layer: CALayer { get }
	
}

public struct DanboAnchorContainer {
	
	fileprivate var body: DanboAnchorCompatible
	
}

extension DanboAnchorContainer {
	
	init(_ body: DanboAnchorCompatible) {
		self.body = body
	}
	
}

extension DanboAnchorContainer {
	
	public var anchor: CGPoint {
		return self.body.layer.anchorPoint
	}
	
}

extension DanboAnchorContainer {
	
	public func put(x: CGFloat, y: CGFloat) {
		
		let anchor = CGPoint(x: x, y: y)
		self.body.layer.anchorPoint = anchor
		
	}
	
	public func put(x: CGFloat) {
		
		self.body.layer.anchorPoint.x = x
		
	}
	
	public func put(y: CGFloat) {
		
		self.body.layer.anchorPoint.y = y
		
	}
	
}

extension UIView: DanboAnchorCompatible { }
