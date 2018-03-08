//
//  ViewController.swift
//  Day-17 Fuzzy Search
//
//  Created by Prashant Gaikwad on 2/15/18.
//  Copyright © 2018 Prashant Gaikwad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var searchTableView: UITableView!
  
  lazy var searchBar:UISearchBar = UISearchBar()

  let namesArray : [String] = ["Prashant","Payal","Saif","Sonali","Pravin","Manasi Kher","Manasi Goel","Trupti","Swapnil","Nilesh","Prashant","Payal","Saif","Sonali","Pravin","Manasi Kher","Manasi Goel","Trupti","Swapnil","Nilesh"]
  
  var filteredData : [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    searchBar.searchBarStyle = .minimal
    searchTableView.dataSource = self
    
    searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
    self.searchTableView.tableHeaderView = searchBar
    
    searchBar.delegate = self
    
    
    //copy main array in temp array for search
    filteredData = namesArray
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.searchTableView.contentOffset = CGPoint(x:0, y:44);

  }
  
//  override func viewWillAppear(_ animated: Bool) {
//    var contentOffset: CGPoint = self.searchTableView.contentOffset
//    contentOffset.y += (self.searchTableView.tableHeaderView?.frame)!.height
//    self.searchTableView.contentOffset = contentOffset
//  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    
  }

  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

//MARK: Other Methods
func setup() {
  
}



//MARK: TableView Methods
extension ViewController : UITableViewDelegate {
  //method called when you select any cell
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}

extension ViewController : UITableViewDataSource {
  
  //tell number of rows for tableview
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredData.count
  }
  
  //get tableview cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
    cell.textLabel?.text = filteredData[indexPath.row]
    return cell
  }
}


//MARK: SearchBar Methods
extension ViewController : UISearchBarDelegate {
  
  //Method called when Cancel button is tapped on Search Bar
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    searchBar.resignFirstResponder()
    searchBar.text = ""
    filteredData = namesArray
    searchTableView.reloadData()
  }
  
  //Method called when Search button is tapped on keyboard
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
    searchBar.showsCancelButton = false
    searchBar.resignFirstResponder()
    searchBar.text = ""
    filteredData = namesArray
    searchTableView.reloadData()
  }
  
  //Method called when text gets begin to editing
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }
  
  //Method gets called text in search bar get changed
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // When there is no text, filteredData is the same as the original data
    // When user has entered text into the search box
    // Use the filter method to iterate over all items in the names array
    // For each item, return true if the item should be included and false if the
    // item should NOT be included
    filteredData = searchText.isEmpty ? namesArray : namesArray.filter { (item: String) -> Bool in
      // If dataItem matches the searchText, return true to include it
      return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
    }
    
    searchTableView.reloadData()
  }
  
}

















