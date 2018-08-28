//
//  ToDoTableViewCell.swift
//  ToDoApp
//
//  Created by Charles Martin Reed on 8/28/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

//using delegation to remove and check off to do list items
protocol ToDoCellDelegate {
    //must integrate these functions to conform
    func didRequestDelete (_ cell:ToDoTableViewCell)
    func didRequestComplete (_ cell:ToDoTableViewCell)
}

class ToDoTableViewCell: UITableViewCell {
    
    //must define delegate property in order for other classes to adopt it
    var delegate: ToDoCellDelegate?
    
    @IBOutlet weak var toDoLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completeToDo(_ sender: Any) {
        //check for delegate
        if let delegateObject = self.delegate {
            delegateObject.didRequestComplete(self)
        }
    }
    
    @IBAction func deleteToDo(_ sender: Any) {
        if let delegateObject = self.delegate {
            delegateObject.didRequestDelete(self)
        }
        
    }
    
}
