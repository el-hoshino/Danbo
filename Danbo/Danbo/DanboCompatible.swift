//
//  DanboCompatible.swift
//  Danbo
//
//  Created by 史翔新 on 2017/05/12.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

public protocol DanboCompatible: class, DanboAnchorCompatible, DanboTransformCompatible {
	
	var danbo: Danbo { get }
	
}

public struct Danbo {
	
	fileprivate let body: DanboCompatible
	
}

extension Danbo {
	
	init(_ body: DanboCompatible) {
		self.body = body
	}
	
}

extension Danbo {
	
	public func anchor(_ anchor: (_ container: DanboAnchorContainer) -> Void) {
		
		let container = DanboAnchorContainer(self.body)
		anchor(container)
		
	}
	
}

extension Danbo {
	
	public func transform(_ transform: (_ container: DanboTransformContainer) -> Void) {
		
		let container = DanboTransformContainer(self.body)
		transform(container)
		
	}
	
}
