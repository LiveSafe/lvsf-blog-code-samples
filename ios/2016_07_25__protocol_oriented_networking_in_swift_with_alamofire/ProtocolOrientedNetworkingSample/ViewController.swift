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
  @IBOutlet var callerLabel: UILabel!

  @IBAction func makeLiveCallPressed(sender: AnyObject) {
    callerLabel.text = "LiveAPIManager"
    getData()
  }

  @IBAction func makeMockCallPressed(sender: AnyObject) {
    callerLabel.text = "TestAPIManager"
    let manager = TestAPIManager(testCondition: .Success)
    getData(fromManager: manager)
  }

  func getData(fromManager manager: APIManager = LiveAPIManager()) {
    responseLabel.text = "Loading..."
    manager.sampleCall { (response) in
      if let content = response.json?.description {
        self.responseLabel.text = "Response = " + content
      }
    }
  }

}
