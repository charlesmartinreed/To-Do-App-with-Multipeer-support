//
//  ToDoTableViewController.swift
//  ToDoApp
//
//  Created by Charles Martin Reed on 8/28/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var todoItems: [ToDoItem]!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    func loadData() {
        todoItems = [ToDoItem]()
        //unsorted list of all the ToDoItem objects; use .sorted by the createdAt property to sort
        todoItems = DataManager.loadAll(ToDoItem.self).sorted(by: {
            $0.createdAt < $1.createdAt
        })
        tableView.reloadData()
        

        
    }
    @IBAction func addNewTodo(_ sender: Any) {
        
        //present an alert with a text field
        let addAlert = UIAlertController(title: "New Todo", message: "Enter a title", preferredStyle: .alert)
        addAlert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "Todo item title"
        }
        addAlert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action: UIAlertAction) in
            //get title, create new object for data model, save it, put into table view
            guard let title = addAlert.textFields?.first?.text else { return }
            
            let newTodo = ToDoItem(title: title, completed: false, createdAt: Date(), itemIdentifier: UUID())
            
            newTodo.saveItem()
            
            self.todoItems.append(newTodo)
            
            //create an index path so that we can place our new item in the tableView with an animation
            let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0), section: 0)
            
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
            
        }))
        
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(addAlert, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell

        let todoItem = todoItems[indexPath.row]
        
        cell.toDoLabel.text = todoItem.title

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
