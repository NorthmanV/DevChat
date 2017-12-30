//
//  CameraVCDelegate.swift
//  DevChat
//
//  Created by Руслан Акберов on 23.12.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import Foundation

protocol CameraVCDelegate {
    func shouldEnableRecordUI(enable: Bool)
    func shouldEnableCameraUI(enable: Bool)
    func canStartRecording()
    func recordingHasStarted()
    func videoRecordingComplete(videoUrl: URL)
    func videoRecordingFail()
//    func snapshotTaken(snapshot: Data)
//    func snapshotFailed()
}
