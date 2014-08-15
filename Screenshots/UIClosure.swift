//
//  UIClosure.swift
//  Screenshots
//
//  Created by Jorge Izquierdo on 09/08/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import UIKit
//TODO: Is it really impossible for this to be an extension?
public typealias SelectorFunction = (object: AnyObject?) -> ()

class ClosureBarButtonItem: UIBarButtonItem {
    
    private var cb: SelectorFunction?
    
    convenience init(title: String, style: UIBarButtonItemStyle, callback: SelectorFunction) {
        
        self.init(title:title, style:style, target:nil, action:Selector("click:"))
        self.target = self
        self.cb = callback
    }

    func click(object: AnyObject?) {
        
        self.cb?(object: object)
    }
}
