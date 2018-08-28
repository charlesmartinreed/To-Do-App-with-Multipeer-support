//
//  ViewController.swift
//  ToDoApp
//
//  Created by Charles Martin Reed on 8/28/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todoItem = ToDoItem(title: "Read the news", completed: false, createdAt: Date(), itemIdentifier: UUID())
        
        //todoItem.saveItem()
        
        let todos = DataManager.loadAll(ToDoItem.self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

