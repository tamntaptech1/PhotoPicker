//
//  PermissionManager.swift
//  PhotoPicker
//
//  Created by SanjayPathak on 19/12/19.
//  Copyright © 2019 Sanjay. All rights reserved.
//

import Foundation
import Photos

class PermissionManager: NSObject {
    
    class func checkAndRequestPhotoAuthorization() -> PHAuthorizationStatus {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            return .authorized
        } else {
            var authStatus = PHAuthorizationStatus.notDetermined
            let semaphore = DispatchSemaphore(value: 0)
            PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) in
                authStatus = status
                semaphore.signal()
            }
            semaphore.wait()
            return authStatus
        }
    }
}
