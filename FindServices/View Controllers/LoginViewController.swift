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
                       let db = Firestore.firestore()
                       let docRef = db.collection("users").document((auth?.user.uid)!)
                       docRef.getDocument { (document, error) in
                           if let document = document, document.exists {
                               let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                               self?.errorLabel.text = "Welcome \(dataDescription)"
                               self?.errorLabel.textColor = .green
                               self?.errorLabel.alpha = 1
                           } else {
                               print("Document does not exist")
                           }
                       }
                   }
            }
        }
    }
    
}
