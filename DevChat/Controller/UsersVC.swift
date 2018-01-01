//
//  UsersVC.swift
//  DevChat
//
//  Created by Руслан Акберов on 28.12.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    private var selectedUsers = [String: User]()
    private var _videoUrl: URL?
    private var _snapData: Data?

    
    var videoUrl: URL? {
        set {
            _videoUrl = newValue
        }
        get {
            return _videoUrl
        }
    }
    
    var snapData: Data? {
        set {
            _snapData = newValue
        }
        get {
            return _snapData
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        navigationItem.rightBarButtonItem?.isEnabled = false
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot) in
            //print("Snap \(snapshot.debugDescription)")
            if let users = snapshot.value as? [String: AnyObject] {
                for (uid, value) in users {
                    if let dict = value as? [String: AnyObject] {
                        if let profile = dict["profile"] as? [String: AnyObject] {
                            if let firstName = profile["firstName"] as? String {
                                let user = User(uid: uid, firstName: firstName)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell {
            cell.updateUI(user: users[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        if let cell = tableView.cellForRow(at: indexPath) as? UserCell {
            cell.setCheckmark(selected: true)
            let user = users[indexPath.row]
            selectedUsers[user.uid] = user
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UserCell {
            cell.setCheckmark(selected: false)
            let user = users[indexPath.row]
            selectedUsers[user.uid] = nil
        }
        if selectedUsers.count < 1 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    @IBAction func sendPRButtonPressed(sender: AnyObject) {
        if let url = _videoUrl {
            let videoName = "\(UUID().uuidString)\(url))"
            let ref = DataService.instance.videoSrorageRef.child(videoName)
            ref.putFile(from: url, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print("Error uploading video: \(error.debugDescription)")
                } else {
                    let downloadUrl = metadata?.downloadURL()
                    print("Download URL: \(String(describing: downloadUrl))")
                    DataService.instance.sendMediaPullRequest(senderUID: Auth.auth().currentUser!.uid, sendingTo: self.selectedUsers, mediaUrl: downloadUrl!, textSnippet: "Test snippet")
                }
            })
            self.dismiss(animated: true, completion: nil)
        } else if let snap = _snapData {
            let ref = DataService.instance.imageStorageRef.child("\(UUID().uuidString).jpg")
            ref.putData(snap, metadata: StorageMetadata(), completion: { (metadata, error) in
                if error != nil {
                    print("Error uploading image: \(error.debugDescription)")
                } else {
                    let downloadUrl = metadata!.downloadURL()
                    print("Download URL: \(String(describing: downloadUrl))")
                    DataService.instance.sendMediaPullRequest(senderUID: Auth.auth().currentUser!.uid, sendingTo: self.selectedUsers, mediaUrl: downloadUrl!, textSnippet: nil)
                }
            })
            self.dismiss(animated: true, completion: nil)
        }
    }
}


















