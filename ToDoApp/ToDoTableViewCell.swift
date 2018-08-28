//
//  ToDoTableViewCell.swift
//  ToDoApp
//
//  Created by Charles Martin Reed on 8/28/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
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
        
        
    }
    
    @IBAction func deleteToDo(_ sender: Any) {
        
        
    }
    
}
