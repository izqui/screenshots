//
//  Screenshot.swift
//  Screenshots
//
//  Created by Jorge Izquierdo on 12/07/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import Foundation
import Photos


extension CGSize: Hashable {
    
    public var hashValue: Int {
    
    get {
        
        return [self.width, self.height].hashValue
    }
    }
}

class Screenshot {
    
    var _asset: PHAsset?
    var _images = Dictionary<CGSize, UIImage>()
    
    init(asset a: PHAsset) {
        
        _asset = a
    }
    
    func imageForSize(size: CGSize, cb: UIImage -> ()) {
        
        if let image = self._images[size] {
            
            cb(image)
            
        } else if _asset != nil {
            
            PhotosHelper.sharedHelper().getImageForSize(self._asset!, size: size) {
                
                image in
                    
                self._images[size] = image
                cb(image)
                
            }
        }
        
    }
    func removeFromCameraRoll(cb: (Void -> Void)?) {
        
        if self._asset != nil {

            PhotosHelper.sharedHelper().removeImages([self], cb:cb)
        }
    }
    
}