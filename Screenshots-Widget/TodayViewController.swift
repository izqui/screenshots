//
//  TodayViewController.swift
//  Screenshots-Widget
//
//  Created by Jorge Izquierdo on 12/07/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var deleteButton: UIButton?
    @IBOutlet var collectionView: UICollectionView?
    
    var screenshots: [Screenshot]?
    
    var vc: UIViewController?
    let cellSize: CGFloat = 50.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.preferredContentSize = CGSize(width: 0, height: cellSize)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width:cellSize, height: cellSize)
        layout.minimumInteritemSpacing = cellSize/5
        
        collectionView!.collectionViewLayout = layout
        displayScreenshots()
       
        //vc = ViewController(coder: nil)
        //self.view.addSubview(vc!.view)
        // Do any additional setup after loading the view from its nib.
    }
    
    @IBAction func removeAll() {
        
        if let sc = screenshots {
            
            PhotosHelper.sharedHelper().removeImages(sc, cb: displayScreenshots)
        }
    }
    
    func displayScreenshots() {
        
        screenshots = PhotosHelper.sharedHelper().getScreenshots()
        self.deleteButton!.setTitle("Remove all \(screenshots!.count)", forState: .Normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encoutered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        displayScreenshots()
        completionHandler(NCUpdateResult.NewData)
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        
        return screenshots!.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = UIColor.yellowColor()
        
        var iv = UIImageView(frame: CGRect(x: 0, y: 0, width:CGRectGetWidth(cell.frame), height:CGRectGetHeight(cell.frame)))
        iv.contentMode = .ScaleAspectFit
        
        var item = screenshots![indexPath.row]
        
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
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        
        
    }

    
}
