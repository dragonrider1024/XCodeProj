//
//  ViewController.swift
//  JSONParser
//
//  Created by Wen Xu on 4/7/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var error : NSError? = nil
        let myjson = NSData(contentsOfFile: "/Users/wenxu/Downloads/hearthstone_basic_set.json", options: nil, error: nil)
        let json : AnyObject? = NSJSONSerialization.JSONObjectWithData(myjson!, options: NSJSONReadingOptions.MutableContainers, error: &error)
        println(json)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

