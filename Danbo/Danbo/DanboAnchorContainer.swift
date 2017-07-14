//
//  DanboAnchorContainer.swift
//  Danbo
//
//  Created by 史翔新 on 2017/05/13.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

public struct DanboAnchorContainer<Containee: DanboCompatible> {
	
	private let body: Containee
	
}

extension DanboAnchorContainer {
	
	init(_ body: Containee) {
		self.body = body
	}
	
}

extension DanboAnchorContainer where Containee: UIView {
	
	public var anchor: CGPoint {
		return self.body.layer.anchorPoint
	}
	
}

extension DanboAnchorContainer where Containee: UIView {
	
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
