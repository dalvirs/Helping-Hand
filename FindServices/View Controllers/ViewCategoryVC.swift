//
//  ViewCategoryVC.swift
//  FindServices
//
//  Created by Dalvir Singh on 2022-04-05.
//

import UIKit

class ViewCategoryVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryTable: UITableView!
    
    let data = CategoryList.getCategory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.delegate = self
        categoryTable.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        categoryTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        let tag = data[indexPath.row]
        cell.viewCell(category: tag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = data[indexPath.row]
        
        let postsVc = self.storyboard?.instantiateViewController(withIdentifier: "viewPostsVC") as! ViewPostsViewController
        
        postsVc.category = selectedPost
        let postsData = DataProvider.getPostByCategory(categoryString: selectedPost)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            postsVc.data = postsData
                    
            self.navigationController?.pushViewController(postsVc, animated: true)
        })

    }
    
}
