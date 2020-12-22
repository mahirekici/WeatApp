//
//  BaseViewController.swift
//  MWeatApp
//
//  Created by mahir ekici on 20.12.2020.
//  Copyright © 2020 mahi rekici. All rights reserved.
//

import UIKit
import Firebase

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.displayFCMToken(notification:)),
                                               name: Notification.Name("FCMToken"), object: nil)
    }
       

    @objc func displayFCMToken(notification: NSNotification){
        guard let userInfo = notification.userInfo else {return}
        if let fcmToken = userInfo["token"] as? String {
          print( "Received FCM token: \(fcmToken)")
        }
      }

}
