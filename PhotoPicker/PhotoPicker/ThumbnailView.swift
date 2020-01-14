//
//  ThumbnailView.swift
//  PhotoPicker
//
//  Created by SanjayPathak on 19/12/19.
//  Copyright © 2019 Sanjay. All rights reserved.
//

import SwiftUI

var images : [Color] = [.red, .green, .blue, .yellow, .gray, .black, .red,.pink, .orange, .purple, .red, .green,.blue, .pink, .orange, .purple,.purple, .red, .green,.blue, .pink, .red, .blue, .green, .red, .black]

struct ThumbnailView : View{
    var body: some View {
        VStack{
            PhotoThumbnailCollectionView()
        }.navigationBarTitle("All Photos")
    }
}

enum ListStyle:Int, CaseIterable{
    case cellSize = 1
    case cellCount = 2
    
    func formatted()->String  {
        var formattedString = ""
        switch self {
        case .cellSize:
            formattedString = "CellSize"
            case .cellCount:
                formattedString = "CellCount"
        }
        return formattedString
    }
}

struct GridStyleSpecifierView : View {
    @State var enteredValue:String = "3"
        @State var selectedListStyle:ListStyle = .cellSize
        let listStyles:[ListStyle] = ListStyle.allCases
        
        var body: some View {
            VStack {
                Picker(selection:$selectedListStyle, label:Text("Select an option")){
                    ForEach(listStyles, id:\.self){ listStyle in
                        Text(listStyle.formatted()).tag(listStyle)
                    }
                }
                TextField("Enter", text: self.$enteredValue)
                Button(action: {
                    print(self.selectedListStyle.formatted())
                }){
                    Text("Apply")
                }
    //            Text("Header \(UIScreen.main.bounds.size.width)")
            }
        }
}

struct HeaderView : View {
    var body: some View {
        VStack {
            Text("Header \(UIScreen.main.bounds.size.width)")
        }
    }
}

struct PhotoThumbnailCollectionView : View {
    @State var numberOfImagesInARow:Int = 3
    var body: some View {
        List {
            ForEach(1...Int(ceil(Float(images.count)/Float(numberOfImagesInARow))), id:\.self){ rowIndex in
                RowView(images: images, columnCount: 3, rowIndex: rowIndex).listRowInsets(.init(top: 0, leading: 16, bottom: 4, trailing: 16))
            }
        } .onAppear {
            UITableView.appearance().separatorStyle = .none
        } .onDisappear {
            UITableView.appearance().separatorStyle = .singleLine
        }
    }
}

struct RowView : View {
    var images: [Color]
    var columnCount: Int
    var rowIndex: Int
    var body: some View {
        HStack() {
            ForEach(1...columnCount, id:\.self){ columnIndex -> PhotoViewCell in
                if self.images.count > (((self.rowIndex - 1) * self.columnCount) + columnIndex - 1) {
                    return PhotoViewCell(image: self.images[((self.rowIndex - 1) * self.columnCount) + columnIndex - 1])
                } else {
                    return PhotoViewCell(image: nil)
                }
            }
        }.frame(width: UIScreen.main.bounds.size.width - 32, height: (UIScreen.main.bounds.size.width - 32)/3, alignment: .leading)//.background(Rectangle().foregroundColor(.black))
    }
}

struct PhotoViewCell : View {
    var image: Color?
    var body: some View {
        VStack {
            if image != nil {
                Rectangle().foregroundColor(image).frame(width: (UIScreen.main.bounds.size.width - 32 - 16)/3, height: (UIScreen.main.bounds.size.width - 32 - 16)/3, alignment: .center)
            }
        }
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView()
    }
}

//struct PhotoThumbnailCollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoThumbnailCollectionView()
//    }
//}

//struct RowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RowView(images: images, columnCount: 3, rowIndex: 1)
//    }
//}

//struct PhotoViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoViewCell(image: images[0])
//    }
//}
