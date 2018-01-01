//
//  CameraVCDelegate.swift
//  DevChat
//
//  Created by Руслан Акберов on 23.12.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import Foundation

@objc protocol CameraVCDelegate {
    @objc optional func shouldEnableRecordUI(enable: Bool)
    @objc optional func shouldEnableCameraUI(enable: Bool)
    @objc optional func canStartRecording()
    @objc optional func recordingHasStarted()
    @objc optional func videoRecordingComplete(videoUrl: URL)
    @objc optional func videoRecordingFail()
    @objc optional func snapshotTaken(snapshotData: Data)
    @objc optional func snapshotFailed()
}
