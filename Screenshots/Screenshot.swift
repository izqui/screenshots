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
    
    enum Orientation {
        
        case Portrait
        case Landscape
    }

    var _asset: PHAsset?
    var _images = Dictionary<CGSize, UIImage>()
    var orientation: Orientation
    var realSize: CGSize
    
    init(asset a: PHAsset, orientation or: Orientation) {
        
        _asset = a
        realSize = CGSize(width: _asset!.pixelWidth, height: _asset!.pixelHeight)
        orientation = or
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
    
    func activityView(cb: (UIActivityViewController -> ())) {
        
        self.imageForSize(realSize) {
            image in
            
            cb(UIActivityViewController(activityItems: [image], applicationActivities: []))
            return
        }
    }
    
    
    
}