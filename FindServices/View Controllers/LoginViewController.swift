//
//  LoginViewController.swift
//  Services
//
//  Created by Dalvir Singh on 2022-03-06.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController : UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginWithGoogle: UIButton!
    @IBOutlet weak var loginWithFacebook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.alpha = 0
    }
    
    @IBAction func loginTaped(_ sender: Any) {
        self.errorLabel.alpha = 0
        if (Validation.validateFields(emailTextField) &&
            Validation.validateFields(passwordTextField)){
            
            let email = Validation.removeWhiteSpaces(emailTextField)!
            let password = Validation.removeWhiteSpaces(passwordTextField)!
            
            Auth.auth().signIn(withEmail: email, password: password)  {[weak self] (auth, err) in
                if (err != nil) {
                    self?.errorLabel.text = err!.localizedDescription
                    self?.errorLabel.alpha = 1
                } else {
                            let homeVc = self?.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController

                            self?.navigationController?.pushViewController(homeVc, animated: true)

                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
}
