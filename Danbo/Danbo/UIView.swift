//
//  UIView.swift
//  Danbo
//
//  Created by 史翔新 on 2017/05/12.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import UIKit

extension UIView: DanboCompatible {
	
	public var danbo: Danbo {
		return Danbo(self)
	}
	
}
