//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import SwiftUI

struct ChooseFilterView: View {
  private let filters = [
    CIFilter(name: "CISepiaTone")!,
    CIFilter(name: "CIVignette", parameters: [kCIInputIntensityKey: 5])!
  ]
  let image: UIImage
  @State private var allImages: [UIImage]
  @State private var selectedImage: UIImage
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

  init(image: UIImage) {
    self.image = image
    self._allImages = State(initialValue: image.filteredImages(filters: filters))
    self._selectedImage = State(initialValue: image)
  }

  var body: some View {
    VStack {
      Image(uiImage: selectedImage)
        .resizable()
        .scaledToFit()
        .overlay(
          HStack {
            Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
              Image(systemName: "chevron.left")
            })
            .foregroundColor(.white)
            Spacer()
            NavigationLink("Next", destination: AddDescriptionView(image: selectedImage))
              .padding(.horizontal)
              .padding(.vertical, 4)
              .background(Color.white)
              .foregroundColor(.accentGreen)
          }
          .padding()
          ,
          alignment: .bottom
        )
      HStack {
        ForEach(allImages, id: \.self) { filteredImage in
          Button(action: {
            self.selectedImage = filteredImage
          }) {
            Image(uiImage: filteredImage)
              .renderingMode(.original)
              .resizable()
              .scaledToFit()
              .frame(width: 80)
          }
        }
        Spacer()
      }
      .frame(height: 166)
      .padding(.horizontal)
      .background(Color.white)
    }
    .navigationBarHidden(true)
  }
}

struct ChooseFilterView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ChooseFilterView(image: UIImage(named: "wanna_play")!)
    }
    NavigationView {
      ChooseFilterView(image: UIImage(named: "puppies")!)
    }
  }
}
