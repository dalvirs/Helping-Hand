//
//  ViewController.swift
//  FindServices
//
//  Created by Dalvir Singh on 2022-03-06.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

        if Auth.auth().currentUser != nil {
            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
            self.navigationController?.pushViewController(homeVc, animated: true)
        }
    }

}

