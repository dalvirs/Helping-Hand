//
//  DataProvider.swift
//  FindServices
//
//  Created by Dalvir Singh on 2022-03-31.
//

import Foundation
import Firebase

class DataProvider{
    
    static var posts = [(String, Posts)]()

    
    static func createPost() -> [(String, Posts)] {
        
        var result = [(String, Posts)]()
        let db = Firestore.firestore()
        db.collection("posts").getDocuments() {(querrySnapshot, error) in
            for document in querrySnapshot!.documents {
                let post = Posts(title: document.get("title") as! String,
                                 location: document.get("location") as! String,
                                 asking: document.get("offering") as! String,
                                 category: document.get("category") as! String,
                                 detail: document.get("detail") as! String,
                                 dateAndTime: document.get("date") as! String,
                                 uId: document.get("uid") as! String)
                result.append((document.get("title") as! String, post))
            }
        }
        return result
        
    }
    
}
