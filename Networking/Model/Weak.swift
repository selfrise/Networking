//
//  Weak.swift
//  Networking
//
//  Created by OO E on 1.05.2021.
//

import Foundation

class Weak<Object: AnyObject> {
    private(set) weak var object: Object?
    
    init(object: Object) {
        self.object = object
    }
}
