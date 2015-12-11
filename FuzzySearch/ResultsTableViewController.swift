//
//  ResultsTableViewController.swift
//  FuzzySearch
//
//  Created by Skyler Tanner on 12/10/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    var wordSectionTitles: [String] = []
    var wordsDataSource: [Word] = []
    var sectionWords: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        //add each words first letter into the wordSectionTitles Array
        wordSectionTitles = []
        _ = wordsDataSource.filter { (word) -> Bool in
            if let firstLetter = word.firstLetter {
                if wordSectionTitles.contains(firstLetter){
                    
                } else {
                    wordSectionTitles.append(firstLetter)
                }
            }
            return true
        }
        
        if wordSectionTitles.count > 0 {
            return wordSectionTitles.count
        } else{
            return 1
        }
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return the number of rows that are in each 
        if wordSectionTitles.count == 0 {
            return wordsDataSource.count
        }
        
        let sectionTitle = wordSectionTitles[section]
        sectionWords = wordsDataSource.filter({ (word) -> Bool in
            if word.firstLetter == sectionTitle {
                return true
            } else {
                return false
            }
        })
        
        return sectionWords.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath)
        
        let sectionTitle = wordSectionTitles[indexPath.section]
        let sectionWords = wordsDataSource.filter({ (word) -> Bool in
            if word.firstLetter == sectionTitle {
                return true
            } else {
                return false
            }
        })

        let word = sectionWords[indexPath.row]
        
        cell.textLabel?.text = word.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if wordSectionTitles.count > 0 {
            return "\(wordSectionTitles[section])"
        } else {
            return ""
        }
        
    }

    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String] {
            return wordSectionTitles
        
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return wordSectionTitles.indexOf(title)!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = self.tableView.indexPathForCell(cell)
        if let indexPath = indexPath {
            let sectionTitle = wordSectionTitles[indexPath.section]
            let sectionWords = wordsDataSource.filter({ (word) -> Bool in
                if word.firstLetter == sectionTitle {
                    return true
                } else {
                    return false
                }
            })
            
            let word = sectionWords[indexPath.row]
            let destinationView = segue.destinationViewController as! DetailWordViewController
            destinationView.word = word
        }
        

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
