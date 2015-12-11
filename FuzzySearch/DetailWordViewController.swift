//
//  DetailWordViewController.swift
//  FuzzySearch
//
//  Created by Skyler Tanner on 12/10/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import UIKit

class DetailWordViewController: UIViewController {

    @IBOutlet weak var definitionLabel: UILabel!
    
    var word: Word?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let word = word {
            updateViewForWord(word)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateViewForWord(word: Word) {
        self.navigationController?.title = word.name
        definitionLabel.text = word.definition
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
