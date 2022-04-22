//
//  ViewPostsViewController.swift
//  FindServices
//
//  Created by Dalvir Singh on 2022-04-03.
//

import Foundation
import UIKit

class ViewPostsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, CustomDelegate{
    
    func callSegue(_ dataObject: AnyObject) {
        self.performSegue(withIdentifier: "chatVc", sender: dataObject)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var category : String = ""
    var data = [Post]()
    var indexSet : IndexSet = []
   // var selectedPost : Post = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category.capitalized
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        data = DataProvider.postsByCategory
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        
        let postsData = data[indexPath.section]
        
        if indexSet.contains(indexPath.row){
            cell.detailText.isHidden = false
            cell.helpButton.isHidden = false
        } else {
            cell.detailText.isHidden = true
            cell.helpButton.isHidden = true
        }
        cell.helpButton.tag = indexPath.row
        cell.helpButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        cell.viewCell(post: postsData)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(data[section].title) offering \(data[section].offering)$"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
      //  selectedPost = data[indexPath.section]
        
        if(indexSet.contains(indexPath.row)){
            indexSet.remove(indexPath.row)
        } else {
            indexSet.insert(indexPath.row)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc func buttonTapped(_ sender:UIButton!){
        self.performSegue(withIdentifier: "viewChats", sender: sender)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! ChatViewController
//        destinationVC.user2UID = "fFbeYVTYq8gVz3rnqRvCASwnweD2"
//        destinationVC.user2Name = "someone"
//    }

}

