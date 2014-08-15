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
    func getScreenSize() -> CGSize {
        
        let bounds = UIScreen.mainScreen().bounds
        if UIDevice.currentDevice().orientation == .Portrait {
            
            return CGSize(width: CGRectGetWidth(bounds), height: CGRectGetHeight(bounds))
        }
        
        return CGSize(width: CGRectGetHeight(bounds), height: CGRectGetWidth(bounds))
    }
    func getScreenshots() -> [Screenshot] {
        
        let assets = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        var screenshots: [Screenshot] = []
        
        let bounds = UIScreen.mainScreen().bounds
        let screensize = self.getScreenSize()
        
        for i in 0 ..< assets.count {
            
            let asset = assets.objectAtIndex(i) as PHAsset
            
            if (asset.pixelWidth == Int(screensize.width*2) && asset.pixelHeight == Int(screensize.height*2)) {
                
                screenshots.append(Screenshot(asset: asset, orientation: (self.getScreenSize().width == CGRectGetWidth(bounds)) ? .Portrait : .Landscape ))
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
    
    func removeImages(images: [Screenshot], cb: (Void -> Void)?) {
        
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            
            var assets: [PHAsset] = []
            
            for i in images {
                
                assets.append(i._asset!)
                
            }
            
            PHAssetChangeRequest.deleteAssets(assets)
            
            }, completionHandler: {
                
                done, error in
                
                if done && !error {
                    
                    cb?()
                }
            })
    }
}