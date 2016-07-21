//
//  ViewController.swift
//  ProtocolOrientedNetworkingSample
//
//  Created by Nicholas Fox on 7/21/16.
//  Copyright © 2016 LiveSafe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var responseLabel: UILabel!

  @IBAction func makeLiveCallPressed(sender: AnyObject) {

    responseLabel.text = "Loading..."
    let manager = LiveAPIManager()
    manager.sampleCall { (response) in
      if let content = response.json?.description {
        self.responseLabel.text = "Live = " + content
      }
    }
  }

  @IBAction func makeMockCallPressed(sender: AnyObject) {

    responseLabel.text = "Loading..."
    let manager = TestAPIManager(testCondition: .Success)
    manager.sampleCall { (response) in
      if let content = response.json?.description {
        self.responseLabel.text = "Mock = " + content
      }
    }
  }

}
