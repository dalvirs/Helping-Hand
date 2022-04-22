//
//  DisplayNameViewController.swift
//  FindServices
//
//  Created by Dalvir Singh on 2022-03-25.
//

import UIKit
import FirebaseAuth

class DisplayNameViewController : UIViewController {
    
    @IBOutlet weak var displayName : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitTapped (_ sender : Any?) {
        guard  let name = displayName.text, !name.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter display name", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { (error) in
            if error == nil {
                let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController

                self.navigationController?.pushViewController(homeVc, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
