//
//  PhotoManager.swift
//  PhotoPicker
//
//  Created by SanjayPathak on 18/12/19.
//  Copyright © 2019 Sanjay. All rights reserved.
//

import Photos

class PhotoManager{
    
    private init(){
    }
    
    static let sharedManager : PhotoManager = {
        let photoManager = PhotoManager()
        return photoManager
    }()
    
    func fetchCollections() -> PHFetchResult<PHAsset>? {
        
        var phAssetInfo = Array<PHAsset>()
        
        if PermissionManager.checkAndRequestPhotoAuthorization() == .authorized {
            let fetchOptions = PHFetchOptions()
            fetchOptions.includeAssetSourceTypes = [.typeUserLibrary, .typeiTunesSynced, .typeCloudShared]
            let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
            fetchResult.enumerateObjects({ asset, _, _ in
                phAssetInfo.append(asset)
            })
            print(phAssetInfo.count)
            return fetchResult
        } else {
            // Prompt the user for permission and go back to root
            return nil
        }
    }
    
    func fetchPhotosFromLibrary() -> Bool {
        return true
    }
}
