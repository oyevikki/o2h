//
//  ImageView.swift
//  O2H
//
//  Created by Vikash on 24/10/23.
//

import SwiftUI


struct ImageView: View {
    @StateObject var imageViewModel = ImagesViewModel()
    @State var currentPage = 1
    @State var imagesDownloaded: [UIImage] = []
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 10)
            ], spacing: 10) {
                ForEach(imageViewModel.images.isEmpty ? imageViewModel.readImagesFromUserDefaults() : imageViewModel.images, id: \.self) { image in
                        
                        Image(uiImage: image)
                        .resizable()
                        .cornerRadius(20)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 150)
                        .onAppear{
                        if image == imageViewModel.images.last {
                            currentPage += 1
                            imageViewModel.fetchImageUrls(page: currentPage, per_page: 11)
                        }
                            
                    }
                }
            }
//            if imageViewModel.isLoading {
//                ProgressView()
//            }
        }
        .onAppear{
            imageViewModel.fetchImageUrls(page: 1, per_page: 11)
            if imageViewModel.images.isEmpty {
                imagesDownloaded = imageViewModel.readImagesFromUserDefaults()
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
