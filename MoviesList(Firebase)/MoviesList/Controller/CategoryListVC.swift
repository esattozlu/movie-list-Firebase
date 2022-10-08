//
//  ViewController.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import UIKit
import Firebase

class CategoryListVC: UIViewController {
    
    @IBOutlet weak var categoryListTableView: UITableView!
    var categoryList = [Category]()
    var reference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryListTableView.delegate = self
        categoryListTableView.dataSource = self
        
        getCategories()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = sender as? Int {
            let destinationVC = segue.destination as! MoviesVC
            destinationVC.selectedCategory = categoryList[index]
        }
    }
    
    func getCategories() {
        reference.child("kategoriler").observe(.value) { snaphot in
            if let categories = snaphot.value as? [String : AnyObject] {
                self.categoryList.removeAll()
                
                for category in categories {
                    if let dictionary = category.value as? NSDictionary {
                        let key = category.key
                        let category_name = dictionary["kategori_ad"] as? String ?? ""
                        
                        let category = Category(kategori_id: key, kategori_ad: category_name)
                        self.categoryList.append(category)
                    }
                }
            }
            DispatchQueue.main.async {
                self.categoryListTableView.reloadData()
            }
            
        }
    }

}


extension CategoryListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedCategory = categoryList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as! CategoriesCell
        cell.categoryLabel.text = selectedCategory.kategori_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMovies", sender: indexPath.row)
    }
    
    
}
