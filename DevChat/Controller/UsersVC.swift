//
//  UsersVC.swift
//  DevChat
//
//  Created by Руслан Акберов on 28.12.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot) in
            print("Snap \(snapshot.debugDescription)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}
