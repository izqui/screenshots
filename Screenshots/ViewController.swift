//
//  ViewController.swift
//  Screenshots
//
//  Created by Jorge Izquierdo on 07/07/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import UIKit
import Photos


class ViewController: UICollectionViewController {
    
    var screenshots = PhotosHelper.sharedHelper().getScreenshots()
    
    @IBOutlet var settingsButton: UIBarButtonItem?
    var deleteAllButton: ClosureBarButtonItem {
        get {
            return ClosureBarButtonItem(title: "Remove all", style: .Plain) {
                
                b in
                
                PhotosHelper.sharedHelper().removeImages(self.screenshots, cb: nil)
                
                return
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Screenshots"
        
        self.navigationItem.leftBarButtonItem = ClosureBarButtonItem(title: "Edit", style: .Plain) {
            
            b in
            let button = b as ClosureBarButtonItem
            
            self.editing = !self.editing
            if self.editing {
                
                button.title = "Cancel"
                self.navigationItem.rightBarButtonItem = self.deleteAllButton
                
            } else {
                
                button.title = "Edit"
                self.navigationItem.rightBarButtonItem = self.settingsButton
            }
            
            return
        }
        
        let frame = self.view.bounds
        let cellSize = (UIDevice.currentDevice().userInterfaceIdiom == .Phone) ? CGRectGetWidth(frame)/3 : CGRectGetWidth(frame)/6
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        layout.minimumInteritemSpacing = (UIDevice.currentDevice().userInterfaceIdiom == .Phone) ? 0 : cellSize/5
        
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.bounces = true
        self.collectionView.alwaysBounceVertical = true
        
        self.collectionView.registerClass(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        
       self.reload()
    }
    
    func reload(){
        
        self.screenshots = PhotosHelper.sharedHelper().getScreenshots()
        self.collectionView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
    
        return screenshots.count
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        
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
    
    override func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        
        screenshots[indexPath.row].activityView {
            activity in
        
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                
                UIPopoverController(contentViewController: activity).presentPopoverFromRect(collectionView.layoutAttributesForItemAtIndexPath(indexPath).frame, inView: self.collectionView, permittedArrowDirections: .Up | .Down, animated: true)
                
            }
            else {
                
                self.presentViewController(activity, animated: true, completion: nil)
            }
            return
        }
    }
}
