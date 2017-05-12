//
//  DanboCompatible.swift
//  Danbo
//
//  Created by 史翔新 on 2017/05/12.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import Foundation

public protocol DanboCompatible: class {
	
	var danbo: Danbo { get }
	
	var transform: CGAffineTransform { get set }
	
}

public struct Danbo {
	
	fileprivate var body: DanboCompatible
	
}

extension Danbo {
	
	init(_ body: DanboCompatible) {
		self.body = body
	}
	
}

extension Danbo {
	
	public func transform(_ transform: (_ container: DanboTransformContainer) -> Void) {
		
		let container = DanboTransformContainer(body: self.body)
		transform(container)
		
	}
	
}
