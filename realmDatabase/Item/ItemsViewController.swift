//
//  ItemsViewController.swift
//  realmDatabase
//
//  Created by goapps on 03.09.2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit
import RealmSwift

class ItemsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var realm: Realm = try! Realm()
    var items: Results<Item>?
    var notificationToken: NotificationToken? = nil
    let s : Stopwatch? = Stopwatch()
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "myDB Item"
        view.addSubview(tableView)
        tableView.frame = self.view.frame
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidClick))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutButtonDidClick)),UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(photoButtonDidClick)) ]
        
        self.items = realm.objects(Item.self).sorted(byKeyPath: "timestamp", ascending: false)
        
        notificationToken = items?.observe { [weak self] (changes) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
                print("Initial database: \(String(describing: self?.s?.elapsedTimeString()))")
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("fatal error \(error)")
            }
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Items: \(items)")
    }

    @objc func addButtonDidClick() {
        let alertController = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            let item = Item()
            item.textString = textField.text ?? ""
            try! self.realm.write {
                self.realm.add(item)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "New Item Text"
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func photoButtonDidClick(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "photoVC") as! PhotosViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    @objc func logoutButtonDidClick() {
        let alertController = UIAlertController(title: "Logout", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes, Logout", style: .destructive, handler: {
            alert -> Void in
            SyncUser.current?.logOut()
            self.navigationController?.setViewControllers([ViewController()], animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                
                let item = items![indexPath.row - 1]
                
                let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
                
                let editAction = UIAlertAction(title: "Edytuj", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    
                    let alertController = UIAlertController(title: "Edit Item", message: "", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
                        alert -> Void in
                        let textField = alertController.textFields![0] as UITextField
                        
                        try! self.realm.write {
                            item.textString = textField.text ?? ""
                            print("Edit item \(String(describing: self.s?.elapsedTimeString()))")
                        }
                    }))
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                        textField.text = item.textString
                    })
                    self.present(alertController, animated: true, completion: nil)
                })
                
                let deleteAction = UIAlertAction(title: "Usuń", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    
                    try! self.realm.write {
                        self.realm.delete(item)
                        print("Delete item \(String(describing: self.s?.elapsedTimeString()))")
                    }
                })
                
                let cancelAction = UIAlertAction(title: "Anuluj", style: .cancel, handler: {
                    (alert: UIAlertAction!) -> Void in
                })
                
                optionMenu.addAction(editAction)
                optionMenu.addAction(deleteAction)
                optionMenu.addAction(cancelAction)
                
                self.present(optionMenu, animated: true, completion: nil)
            }
        }
    }
}

extension ItemsViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        let item = items![indexPath.row]
        cell.textLabel?.text = item.textString
        cell.accessoryType = item.isDone ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items![indexPath.row]
        try! realm.write {
            item.isDone = !item.isDone
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let item = items![indexPath.row ]
        try! realm.write {
            realm.delete(item)
        }
    }
}

