//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
  let activityItems: [Any]

  func makeUIViewController(context: Context) -> some UIViewController {
    let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    // nothing needed
  }
}

struct ShareSheet_Previews: PreviewProvider {
  static var previews: some View {
    ShareSheet(activityItems: ["Sample text"])
  }
}
