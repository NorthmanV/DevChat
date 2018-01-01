//
//  CameraVC.swift
//  DevChat
//
//  Created by Руслан Акберов on 21.12.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: CameraViewController, CameraVCDelegate {
    
    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var changeModeControl: UISegmentedControl!
    @IBOutlet weak var myCameraButton: UIButton!
    @IBOutlet weak var myRecordButton: UIButton!
    
    var index: Int = 0
    
    override func viewDidLoad() {
        _previewView = previewView
        changeModeControl = captureModeControl
        delegate = self
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard Auth.auth().currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
    }

    @IBAction func recordButtonPressed(_ sender: UIButton) {
        print("toggle pressed!!!")
        if index == 0 {
            capturePhoto(sender)
        } else {
            toggleMovieRecording(sender)
        }
    }
    
    @IBAction func changeCameraButtonPressed(_ sender: UIButton) {
        print("changeCameraButtonPressed")
        changeCamera(sender)
    }
    
    @IBAction func toggleCaptureModeControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            index = 0
            print("selectedSegmentIndex == 0")
        } else {
            index = 1
            print("selectedSegmentIndex == 1")
        }
        toggleCaptureMode(sender)
    }
    
    func shouldEnableRecordUI(enable: Bool) {
        myRecordButton.isEnabled = enable
        print("shouldEnableRecordUI \(enable)")
    }
    
    func shouldEnableCameraUI(enable: Bool) {
        myCameraButton.isEnabled = enable
        print("shouldEnableCameraUI \(enable)")
    }
    
    func canStartRecording() {
        print("recordingHasStarted")
    }
    
    func recordingHasStarted() {
        print("recordingHasStarted")
    }

    
    func videoRecordingComplete(videoUrl: URL) {
        performSegue(withIdentifier: "UsersVC", sender: ["videoUrl": videoUrl])
    }
    
    func videoRecordingFail() {
        
    }
    
    func snapshotTaken(snapshotData: Data) {
        performSegue(withIdentifier: "UsersVC", sender: ["snapshotData": snapshotData])
    }
    
    func snapshotFailed() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let usersVC = segue.destination as? UsersVC {
            if let videoUrl = sender as? [String: URL] {
                let url = videoUrl["videoUrl"]
                usersVC.videoUrl = url
            } else if let snapData = sender as? [String: Data] {
                usersVC.snapData = snapData["snapshotData"]
            }
        }
    }

    
    
    
    
    
}

