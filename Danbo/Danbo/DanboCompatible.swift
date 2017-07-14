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
	
	public func set(_ setting: (_ container: DanboSettingContainer<Containee>) -> DanboSettingContainer<Containee>.Finished) {
		
		let container = DanboSettingContainer(self.body)
		let result = setting(container)
		
		switch result {
		case .success:
			break
		}
		
	}
	
}

extension DanboContainer {
	
	public func anchor(_ anchor: (_ container: DanboAnchorContainer<Containee>) -> DanboAnchorContainer<Containee>.Finished) {
		
		let container = DanboAnchorContainer(self.body)
		let result = anchor(container)
		
		switch result {
		case .success:
			break
		}
		
	}
	
}

extension DanboContainer {
	
	public func transform(_ transform: (_ container: DanboTransformContainer<Containee>) -> DanboTransformContainer<Containee>.Finished) {
		
		let container = DanboTransformContainer(self.body)
		let result = transform(container)
		
		switch result {
		case .success:
			break
		}
		
	}
	
}
