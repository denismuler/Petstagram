//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import SwiftUI

struct AppTitle: View {
  var body: some View {
    Text("petstagram")
      .font(.custom("CoolStoryregular", size: 48))
  }
}

struct AppTitle_Previews: PreviewProvider {
  static var previews: some View {
    AppTitle()
      .previewLayout(.sizeThatFits)
  }
}
