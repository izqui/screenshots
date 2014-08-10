//
//  TodayViewController.swift
//  Screenshots-Widget
//
//  Created by Jorge Izquierdo on 12/07/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController {
        
    @IBOutlet var label: UILabel?
    var vc: UIViewController?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.label!.text = String(Int(UIScreen.mainScreen().bounds.size.height))
        
        var sc = PhotosHelper.sharedHelper().getScreenshots()
        self.label!.text = String(sc.count)
        //PhotosHelper.sharedHelper().removeImages(sc, cb: {})
        
        //vc = ViewController(coder: nil)
        //self.view.addSubview(vc!.view)
        // Do any additional setup after loading the view from its nib.
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

        completionHandler(NCUpdateResult.NewData)
    }
    
}
