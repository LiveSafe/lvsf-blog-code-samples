//
//  File.swift
//  LiveSafe
//
//  Created by Nicholas Fox on 5/1/16.
//  Copyright © 2016 LiveSafe. All rights reserved.
//

import Foundation

class JSONFileReader {

  class func getJSONNamed(filename: String) -> NSDictionary? {

    let myBundle = NSBundle.init(forClass: self)
    if let path = myBundle.pathForResource(filename, ofType: "json") {
      do {
        let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options:.MutableContainers)
        let dictionary = jsonResult as? NSDictionary
        return dictionary ?? nil

      } catch let error as NSError {
        print(error.localizedDescription)
        return nil
      }
    } else {
      print("Invalid filename/path.")
      return nil
    }
  }

}
