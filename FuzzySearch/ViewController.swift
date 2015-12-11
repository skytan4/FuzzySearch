//
//  ViewController.swift
//  FuzzySearch
//
//  Created by Skyler Tanner on 12/9/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var wordsDataSource: [Word] = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchController()
        wordsDataSource = WordController.sharedInstance.words
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.wordsDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath)
        
        let word = self.wordsDataSource[indexPath.row]
        
        cell.textLabel?.text = word.name
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpSearchController() {
        
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("wordSearchResults")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchTerm = searchController.searchBar.text!.lowercaseString
        
        let resultsViewController = searchController.searchResultsController as! ResultsTableViewController
        
        resultsViewController.wordsDataSource = self.wordsDataSource.filter({ ($0.name!.lowercaseString.containsString(searchTerm))})

        resultsViewController.tableView.reloadData()
    }

}

