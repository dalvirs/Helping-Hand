//
//  Cell.swift
//  FindServices
//
//  Created by Dalvir Singh on 2022-04-03.
//

import Foundation
import UIKit
import Firebase

class Cell : UITableViewCell {

    @IBOutlet weak var offering: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var locationText: UILabel!
    @IBOutlet weak var helpButton: UIButton!
    
    var recieverUid : String = ""
    func viewCell(post : Post) {
        postTitle.text = post.title
        offering.text = post.offering
        detailText.text = "\n\(post.detail) \n Date and Time: \(post.date)\n"
        locationText.text = "\n\(post.location)"
        let documentId = post.documentId.components(separatedBy: " ")
        recieverUid = documentId[0]
    }
    
    @IBAction func helpTapped(_ sender: Any) {
        let currentUser = Auth.auth().currentUser
        let db = Firestore.firestore()
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "YY, MMM d, HH:mm:ss"
        db.collection("Chats").addDocument(data:
            [
                "senderId" : currentUser?.uid ?? "",
                "senderName" : currentUser?.displayName ?? " ",
                "recieverId" : recieverUid,
            "date" : format.string(from: date),
             "message" : "I can help"])
    }
    
}
