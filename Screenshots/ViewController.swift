//
//  ViewController.swift
//  Screenshots
//
//  Created by Jorge Izquierdo on 07/07/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var screenshots = PhotosHelper.sharedHelper().getScreenshots()
    var collectionView: UICollectionView
    
    init(frame: CGRect) {
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        layout.itemSize = CGSize(width: CGRectGetWidth(frame)/6, height: CGRectGetWidth(frame)/6)
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.collectionView.scrollEnabled = true
        super.init(coder: nil)
        //self.view.frame = UIScreen.mainScreen().bounds
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.collectionView.registerClass(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(self.collectionView)
        
        self.collectionView.reloadData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.screenshots = PhotosHelper.sharedHelper().getScreenshots()
        self.collectionView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
    
        return screenshots.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        
        var iv = UIImageView(frame: CGRect(x: 0, y: 0, width:CGRectGetWidth(cell.frame), height:CGRectGetHeight(cell.frame)))
        iv.contentMode = .ScaleAspectFit
        
        var item = screenshots[indexPath.row]
        
        item.imageForSize(cell.frame.size) {
            
            image in
            
            iv.image = image
            
        }
        
        for s in cell.subviews {
            
            s.removeFromSuperview()
        }
        
        cell.addSubview(iv)
        return cell
        
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        UIView.animateWithDuration(duration) {
            
            self.collectionView.frame = self.view.frame
            self.collectionView.layoutIfNeeded()
        }
    }
}
