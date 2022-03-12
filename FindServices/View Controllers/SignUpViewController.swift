//
//  SignUpViewController.swift
//  Services
//
//  Created by Dalvir Singh on 2022-03-06.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController : UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        //        Utilities.styleTextField(password)
        //        Utilities.styleTextField(phoneNumber)
        //        Utilities.styleTextField(email)
        //        Utilities.styleTextField(firstName)
        //        Utilities.styleTextField(lastName)
        //        Utilities.styleFilledButton(signUpBtn)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        self.errorLabel.alpha = 0
        guard let firstNameString = firstName.text, !firstNameString.isEmpty,
              let lastNameString = lastName.text, !lastNameString.isEmpty,
              let phoneNumberString = phoneNumber.text, !phoneNumberString.isEmpty,
              let emailString = email.text, !emailString.isEmpty,
              let passwordString = password.text, !passwordString.isEmpty
        else {
            self.errorLabel.text = "Please fill up all the fields"
            self.errorLabel.alpha = 1
            return
        }
            Auth.auth().createUser(withEmail: emailString, password: passwordString) { (auth, err) in
                if (err != nil) {
                    self.errorLabel.text = err!.localizedDescription
                    self.errorLabel.alpha = 1
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").document(auth!.user.uid).setData(
                        ["first_name" : firstNameString,
                         "last_name" : lastNameString,
                         "email" : emailString,
                         "phone_number" : phoneNumberString]) { err in
                             if (err != nil) {
                                 self.errorLabel.text = "Can not add data to database"
                                 self.errorLabel.alpha = 1
                             }
                         }
                }
            }
        
    }
    
    
}
