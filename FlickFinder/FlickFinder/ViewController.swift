//
//  ViewController.swift
//  FlickFinder
//
//  Created by Wen Xu on 4/1/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

import UIKit
let BASE_URL = "https://api.flickr.com/services/rest/"
let METHOD_NAME = "flickr.photos.search"
let API_KEY = "5bec0f33beab53218b1acecc44e93f43"
//let GALLERY_ID = "5704-72157622566655097"
let EXTRAS = "url_m"
let DATA_FORMAT = "json"
let NO_JSON_CALLBACK = "1"


class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    @IBOutlet weak var photoTitle: UILabel!
    
    @IBOutlet weak var searchTextButton: UIButton!
    @IBOutlet weak var searchLocButton: UIButton!
    
    @IBAction func TouchUpSearchText(sender: UIButton) {
        searchPhotosByPhraseButtonTouchUp(sender)
    }


    @IBAction func TouchUpSearchLoc(sender: UIButton) {
        searchPhotosByPhraseButtonTouchUp(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchPhotosByPhraseButtonTouchUp(sender: UIButton) {
        let methodArgumentsByText = [
            "method" : METHOD_NAME,
            "api_key" : API_KEY,
            "extras" : EXTRAS,
            "format" : DATA_FORMAT,
            "nojsoncallback" : NO_JSON_CALLBACK,
            "text" : self.searchText.text!
        ]
        
        let methodArgumentsByLoc = [
            "method" : METHOD_NAME,
            "api_key" : API_KEY,
            "extras": EXTRAS,
            "format": DATA_FORMAT,
            "nojsoncallback": NO_JSON_CALLBACK,
            "lat": self.latitude.text!,
            "lon": self.longitude.text!
        ]
        
        
        let session = NSURLSession.sharedSession()
        var urlString = BASE_URL
        if (sender.isEqual(self.searchTextButton)) {
            urlString += escapedParameters(methodArgumentsByText)
        }
        else {
            urlString += escapedParameters(methodArgumentsByLoc)
        }
//        println("url is \(urlString)")
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL : url)
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            if let error = downloadError? {
                println("Could not complete the request \(error)")
            } else {
                /* 5 - Success! Parse the data */
                var parsingError: NSError? = nil
                let parsedResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
                if let photosDictionary = parsedResult.valueForKey("photos") as? NSDictionary {
                    if let photoArray = photosDictionary.valueForKey("photo") as? [[String: AnyObject]] {
                        if (!photoArray.isEmpty) {
                            /* 6 - Grab a single, random image */
                            let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
                            let photoDictionary = photoArray[randomPhotoIndex] as [String: AnyObject]
                            
                            /* 7 - Get the image url and title */
                            let photoTitle = photoDictionary["title"] as? String
                            let imageUrlString = photoDictionary["url_m"] as? String
                            let imageURL = NSURL(string: imageUrlString!)
                            
                            /* 8 - If an image exists at the url, set the image and title */
                            if let imageData = NSData(contentsOfURL: imageURL!) {
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.image.image = UIImage(data: imageData)
                                    self.photoTitle.text = photoTitle
                                })
                            }
                                
                            else {
                                println("Image does not exist at \(imageURL)")
                            }
                        }
                        else {
                            println("Search result in empty photo array")
                        }
                        
                    } else {
                        println("Cant find key 'photo' in \(photosDictionary)")
                    }
                } else {
                    println("Cant find key 'photos' in \(parsedResult)")
                }
            }
        }
        
        /* 9 -Resume (execute) the task */
        task.resume()
    }
    /* Helper function: Given a dictionary of parameters, convert to a string for a url */
    func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            
            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            /* FIX: Replace spaces with '+' */
            let replaceSpaceValue = stringValue.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            /* Append it */
            urlVars += [key + "=" + "\(replaceSpaceValue)"]
        }
        
        return (!urlVars.isEmpty ? "?" : "") + join("&", urlVars)
    }

}

