//
//  ContentView.swift
//  PhotoPicker
//
//  Created by SanjayPathak on 18/12/19.
//  Copyright © 2019 Sanjay. All rights reserved.
//

import SwiftUI

struct RootView: View {
    //    @State var isPhotoPermissionGranted = false
    @State var selection: Int? = nil
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ThumbnailView(), tag: 1, selection: $selection){
                    Button(action: {
                        if PermissionManager.checkAndRequestPhotoAuthorization() == .authorized {
                            self.selection = 1
                        }
                    }) {
                        Text("Show Collections")
                    }
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
