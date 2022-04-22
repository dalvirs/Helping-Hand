//
//  MyPosts.swift
//  FindServices
//
//  Created by Dalvir Singh on 2022-04-20.
//

import Foundation
import UIKit
import Firebase

class MyPosts : UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var data = DataProvider.getMyPosts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Posts"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        data = DataProvider.myPosts
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPosts", for: indexPath) as! MyPostsCell
        
        let postsData = data[indexPath.section]
        
        cell.viewCell(post: postsData)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let post = data[indexPath.section]
        
        
        let action = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.completionHandler(post.postId)
            self?.data = DataProvider.getMyPosts()
            self?.tableView.reloadData()
            completionHandler(true)
        }
        
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    func completionHandler(_ postId : String ) {
        let db = Firestore.firestore()
        db.collection("posts")
            .whereField("postId", isEqualTo: postId)
            .getDocuments() {(querrySnapshot, error) in
            for document in querrySnapshot!.documents
                {
                document.reference.delete()
            }
    }
}

}
