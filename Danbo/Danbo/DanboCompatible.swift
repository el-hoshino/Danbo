//
//  DanboCompatible.swift
//  Danbo
//
//  Created by 史翔新 on 2017/05/12.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

public protocol DanboCompatible: class {
	
	associatedtype Danbo
	
	var danbo: Danbo { get }
	
}

public struct DanboContainer<Containee: DanboCompatible> {
	
	fileprivate let body: Containee
	
}

extension DanboContainer {
	
	init(_ body: Containee) {
		self.body = body
	}
	
}

extension DanboContainer {
	
	public func anchor(_ anchor: (_ container: DanboAnchorContainer<Containee>) -> Void) {
		
		let container = DanboAnchorContainer(self.body)
		anchor(container)
		
	}
	
}

extension DanboContainer {
	
	public func transform(_ transform: (_ container: DanboTransformContainer<Containee>) -> Void) {
		
		let container = DanboTransformContainer(self.body)
		transform(container)
		
	}
	
}
