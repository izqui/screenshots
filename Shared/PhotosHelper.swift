//
//  PhotosHelper.swift
//  Screenshots
//
//  Created by Jorge Izquierdo on 12/07/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import Foundation
import Photos

class PhotosHelper {
    
    struct Static {
        
        static var token: dispatch_once_t = 0
        static var instance: PhotosHelper?
    }
    
    class func sharedHelper() -> PhotosHelper {
        
        dispatch_once(&Static.token) {
            
            Static.instance = PhotosHelper()
        }
        
        return Static.instance!
    }
    
    func getScreenshots() -> [Screenshot] {
        
        let assets = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        var screenshots: [Screenshot] = []
        
        for i in 0 ..< assets.count {
            
            let asset = assets.objectAtIndex(i) as PHAsset
            
            if (asset.pixelWidth == UIScreen.mainScreen().bounds.size.width*2 && asset.pixelHeight == UIScreen.mainScreen().bounds.size.height*2) || (asset.pixelHeight == UIScreen.mainScreen().bounds.size.width*2 && asset.pixelWidth == UIScreen.mainScreen().bounds.size.height*2) { //UIScreen bounds changes on rotation
                
                screenshots.append(Screenshot(asset: asset))
            }
            
        }
        
        return screenshots
    }
    
    func getImageForSize(asset: PHAsset, size:CGSize, cb: (UIImage) -> ()) {
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: size, contentMode: .AspectFill, options: nil){
            
            image, info in
            
            cb(image)
        }
        
    }
    
    func removeImages(images: [Screenshot],cb: Void -> Void) {
        
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            
            var assets: [PHAsset] = []
            
            for i in images {
                
                assets.append(i._asset!)
                
            }
            
            PHAssetChangeRequest.deleteAssets(assets)
            
            }, completionHandler: {
                
                done, error in
                
                if done && !error {
                    
                    cb()
                }
            })
        
    }
}