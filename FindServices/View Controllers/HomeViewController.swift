//
//  HomeViewController.swift
//  Services
//
//  Created by Dalvir Singh on 2022-03-06.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController : UIViewController {
    
    @IBOutlet weak var viewPosts: UIButton!
    @IBOutlet weak var post: UIButton!
    @IBOutlet weak var signOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displayName : String = "Welcome \((Auth.auth().currentUser?.displayName)!)"
        
        viewPosts.layer.cornerRadius = 20
        post.layer.cornerRadius = 20
        signOutBtn.layer.cornerRadius = 20
        
        title = displayName.capitalized
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let mainVc = self.storyboard?.instantiateViewController(withIdentifier: "mainViewController") as! ViewController
            self.navigationController?.pushViewController(mainVc, animated: true)
        } catch {
            
        }
    }
    
}
