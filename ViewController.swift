
//  ViewController.swift
//  ContactListApp
//
//  Created by Esraa Hassan on 10/9/20.
//  Copyright © 2020 jets. All rights reserved.
//

import UIKit
import SQLite3
class ViewController: UITableViewController {
    var db:OpaquePointer?
    var dataSource = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlertController))
    
         db = openDatabase()
        createTable(db: db)
        query(db: db)
    }
    
    func openDatabase() -> OpaquePointer? {
        var db:OpaquePointer?
        let fileUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Contacts.sqlite")
        if sqlite3_open(fileUrl?.path, &db) == SQLITE_OK{
            print("Successfully opened connection to database")
            return db
        }else{
            print("unable to open database.")
            return nil
        }
    }
    
    func createTable(db:OpaquePointer?){
        let createTableString = """
        CREATE TABLE Contact(Id INT PRIMARY KEY NOT NULL,
        Name CHAR(255));
"""
        //1
        var createTableStatment:OpaquePointer?
        
        //2
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatment, nil) == SQLITE_OK{
           //3
            if sqlite3_step(createTableStatment) == SQLITE_DONE {
                print("\nContact table created")
            }else{
                print("\nContact table is not created")
            }
        }else{
            print("Create table statment is not prepared")
        }
        //4
        sqlite3_finalize(createTableStatment)
    }
    
    func insert(id:Int32,name:NSString,db:OpaquePointer?){
        let insertStatementString = "INSERT INTO Contact (Id,Name) VALUES (?, ?);"
        var insertStatment:OpaquePointer?
        //1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatment, nil) == SQLITE_OK{
            
            //2
            sqlite3_bind_int(insertStatment, 1, id)
            
            //3
            sqlite3_bind_text(insertStatment, 2, name.utf8String, -1, nil)
            
            //4
            if sqlite3_step(insertStatment) == SQLITE_DONE{
                print("\nSuccessfully inserted row")
            }else{
                showErrorMessage(message: "User with this ID already exists")
            }
        }else{
            print("Insert statment is not prepared")
        }
        //5
        sqlite3_finalize(insertStatment)
    }
    
    func query(db: OpaquePointer?) {
        dataSource.removeAll()
        
        let queryStatementString = "SELECT * FROM Contact;"
        var queryStatement: OpaquePointer?
        // 1
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            // 2
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                // 3
                let id = sqlite3_column_int(queryStatement, 0)
                // 4
                guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
                    print("Query result is nil")
                    return
                }
                let name = String(cString: queryResultCol1)
                // 5
                print("\nQuery Result:")
                print("\(id) | \(name)")
                dataSource.append("\(id) | \(name)")
            }
            self.tableView.reloadData()
        } else {
            // 6
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        // 7
        sqlite3_finalize(queryStatement)
    }
    
    func delete(db:OpaquePointer?){
        let deleteStatementString = "DELETE FROM Contact WHERE Id = 1;"
        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
            SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("\nSuccessfully deleted row.")
            } else {
                print("\nCould not delete row.")
            }
        } else {
            print("\nDELETE statement could not be prepared")
        }
        
        sqlite3_finalize(deleteStatement)

    }
    
    @objc func showAlertController(){
        let ac = UIAlertController(title: "Enter contact", message: nil, preferredStyle: .alert)
        ac.addTextField { (tf) in
            tf.placeholder = "enter id"
        }
        ac.addTextField { (tf) in
            tf.placeholder = "enter name"
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self,weak ac] action in
            guard let id = ac?.textFields?[0].text else{
                return
            }
            guard let name = ac?.textFields?[1].text else{
                return
            }
            guard let idAsInt = Int32(id) else{return}
            self?.insert(id: idAsInt, name: name as NSString, db: self?.db)
            self?.query(db: self?.db)
        }
        ac.addAction(submitAction)
        present(ac,animated: true)
    }
    
    func showErrorMessage(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell")
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }


}

