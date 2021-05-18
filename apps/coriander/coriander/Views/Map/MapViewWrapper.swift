//
//  MapViewWrapper.swift
//  coriander
//
//  Created by Tomas Korcak on 18.05.2021.
//

//import SwiftUI
//
//struct MapViewWrapper: View {
//    @State private var image: Image?
//    @State private var showingImagePicker = false
//    @State private var inputImage: UIImage?
//    
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//
//            Button("Select Image") {
//                showingImagePicker = true
//            }
//        }
//        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
//            ImagePicker(image: self.$inputImage)
//        }
//    }
//    
//    func loadImage() {
//        guard let inputImage = inputImage else {
//            return
//        }
//        
//        image = Image(uiImage: inputImage)
//    }
//}
//
//struct MapViewWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        MapViewWrapper()
//    }
//}
