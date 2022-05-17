//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import SwiftUI

struct AddDescriptionView: View {
  var image: UIImage
  @State var description = ""
  @StateObject private var controller = PostController()
  @EnvironmentObject var userData: UserData
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 160)
          .clipped()
        Spacer()
      }

      Text("Add a description:")
      TextEditor(text: $description)
      Spacer()

      HStack {
        Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
          Image(systemName: "chevron.left")
        })
        .foregroundColor(.accentGreen)
        Spacer()
        ZStack {
          if controller.isRunning {
            ProgressView()
          }
          Button(action: {
            controller.uploadPost(withDescription: description, image: image)
          }) {
            Text("Post")
          }
          .foregroundColor(controller.isRunning ? .gray : .accentGreen)
          .disabled(controller.isRunning)
          .onReceive(controller.$postUploaded) { completed in
            if completed {
              self.userData.selectedTab = 0
            }
          }
          .alert(isPresented: $controller.postError) {
            Alert(title: Text(controller.postErrorText))
          }
        }
      }
    }
    .padding()
    .navigationBarHidden(true)
  }
}

struct AddDescriptionView_Previews: PreviewProvider {
  static var previews: some View {
    AddDescriptionView(image: UIImage(named: "puppies")!)
      .environmentObject(UserData())
  }
}
