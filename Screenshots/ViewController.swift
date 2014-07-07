//
//  ViewController.swift
//  Screenshots
//
//  Created by Jorge Izquierdo on 07/07/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
                            
    @IBOutlet var imageView: UIImageView
    override func viewDidLoad() {
        super.viewDidLoad()

        removeScreenshots()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeScreenshots() {
        
        let assets = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        
        for i in 0..assets.count {
            
            let asset = assets.objectAtIndex(i) as PHAsset
            
            if asset.pixelWidth == 186 && asset.pixelHeight == 423 {
                
                PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSize(width: 186, height:423), contentMode: .AspectFill, options: nil){
                    
                    image, info in
                    
                    self.imageView.image = image
                    
                }
            }
        }
    }
}

