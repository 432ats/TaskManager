//
//  TaskManagerTableTableViewController.swift
//  TaskManager
//
//  Created by AtsushiShimizu on 2020/05/02.
//  Copyright © 2020 ats432. All rights reserved.
//

import UIKit
import RealmSwift

class TaskManagerTableTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    @IBAction func didTapAddButton(_ sender: Any) {
        // ＋ボタンをタップしたときに呼ばれます。
        
        // アラートを定義する
        let alertController = UIAlertController(title: "Taskを追加しますか？", message: nil, preferredStyle: .alert)
        
        // ボタンを定義する
        let action:UIAlertAction = UIAlertAction(title: "追加", style: .default) { (void) in
            
            let textField = alertController.textFields![0] as UITextField
            if let text = textField.text {
                
                
                let task = Task()
                task.text = text
                
                let realm = try! Realm()
                try! realm.write {
                    realm.add(task)
                }
                
                self.tableView.reloadData()
            }
            
        }
        
        // キャンセルボタンを定義する
        let cancel:UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        //
        alertController.addTextField { (textField) in
            textField.placeholder = "Taskの名前を入れてください"
        }
        // アラートに定義したボタンとキャンセルボタンを追加する
        alertController.addAction(action)
        alertController.addAction(cancel)
        
        // アラートを表示する
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let realm = try! Realm()
        let tasks = realm.objects(Task.self)
        
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let realm = try! Realm()
        let tasks = realm.objects(Task.self)
        
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.text
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let realm = try! Realm()
            let tasks = realm.objects(Task.self)
            let task = tasks[indexPath.row]
            
            try! realm.write {
                realm.delete(task)
            }
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
