//
//  PicturesViewController.swift
//  realmDatabase
//
//  Created by goapps on 03.09.2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit
import RealmSwift

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var realm: Realm = try! Realm()
    var photos: Results<Photo>?
    var notificationToken: NotificationToken? = nil
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image controller"
        
        view.addSubview(tableView)
        tableView.frame = self.view.frame
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "photoCell")
        
        self.photos = realm.objects(Photo.self).sorted(byKeyPath: "imageName", ascending: false)
        
        notificationToken = photos?.observe { [weak self] (changes) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("fatal error \(error)")
            }
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.white

        print("Photos: \(String(describing: photos))")
        
    }
}

extension PhotosViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
        cell.selectionStyle = .none
        let photo = photos![indexPath.row]
        cell.textLabel?.text = photo.imageName
        cell.imageView?.image = UIImage(data:photo.image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos!.count
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let photo = photos[indexPath.row]
//        try! realm.write {
//
//        }
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let item = photos![indexPath.row]
        try! realm.write {
            realm.delete(item)
        }
    }
}
