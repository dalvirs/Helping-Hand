//
//  PostViewController.swift
//  FindServices
//
//  Created by Dalvir Singh on 2022-03-19.
//

import UIKit
import Firebase
import FirebaseAuth
import AYPopupPickerView

class PostViewController : UIViewController{
    
    let categoryList = CategoryList.getCategory()
    
    @IBOutlet weak var dateTextField: UILabel!
    @IBOutlet weak var categoryTextField: UILabel!
    @IBOutlet weak var detailField: UITextView!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var asking: UITextField!
    @IBOutlet weak var location: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailField.layer.borderWidth = 1.0
        detailField.layer.borderColor = UIColor.darkGray.cgColor
        
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        
        guard let postTitle = postTitle.text, !postTitle.isEmpty,
              let loc = location.text, !loc.isEmpty,
              let offer = asking.text, !offer.isEmpty,
              let category = categoryTextField.text, category.contain(categoryList),
              let detail = detailField.text, !detail.isEmpty,
              let date = dateTextField.text, !date.contain(["Select Date and Time"])
        else {
            let alert = UIAlertController(title: "Error", message: "Please enter all fields", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("posts").document().setData(
            ["uid" : uid!,
             "title" : postTitle,
             "location" : loc,
             "offering" : offer,
             "category" : category,
             "detail" : detail,
             "date" : date,
             "postId" : UUID().uuidString]) {err in
                 if err != nil {
                     print("something went wrong")
                 }
             }
        let myPostVc = self.storyboard?.instantiateViewController(withIdentifier: "myPosts") as! MyPosts
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            
            myPostVc.data = DataProvider.getMyPosts()
    
            self.navigationController?.pushViewController(myPostVc, animated: true)
        })

    }
        
    
    
    @IBAction func categoriesTapped(_ sender: Any) {
        
        let popupPickerView = AYPopupPickerView()
        popupPickerView.display(itemTitles: categoryList, doneHandler: {
            let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
            self.categoryTextField.text = self.categoryList[selectedIndex]
        })
        
    }
    
    @IBAction func dateTapped(_ sender: Any) {
        let popupDatePickerView = AYPopupDatePickerView()
        popupDatePickerView.display(defaultDate: Date(), doneHandler: { date in
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "YY/MM/dd HH:MM"
            self.dateTextField.text = dateFormater.string(from: date)
        })
    }
    
}

extension String {
    func contain(_ strings: [String]) -> Bool {
        strings.contains { contains($0) }
    }
}
