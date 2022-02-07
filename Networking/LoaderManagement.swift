//
//  LoaderManagement.swift
//  Networking
//
//  Created by Özgün Ergen on 7.02.2022.
//

import UIKit
import LoadingLibrary

public class LoaderManagement {
    
    var loader = Loading()
    
    public func showLoader() {
        
        loader.setDuration(second: 5).show()
    }
    
    
    public func setLoader() {
        loader.setDefaultAppearance()
        
    }
}
