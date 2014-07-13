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
    
    var hashValue: Int {
    
    get {
        
        return "\(Int(self.width))0\(Int(self.height))".toInt()!
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
            
        } else if _asset {
            
            PhotosHelper.sharedHelper().getImageForSize(self._asset!, size: size) {
                
                image in
                    
                self._images[size] = image
                cb(image)
                
            }
        }
        
    }
    func removeFromCameraRoll(cb: (Void -> Void)?) {
        
        if self._asset {

            PhotosHelper.sharedHelper().removeImages([self]) {
                
                if cb {
                    cb!()
                }
            }
        }
    }
    
}