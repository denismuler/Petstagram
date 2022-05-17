//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import SwiftUI

struct CommentCell: View {
  var comment: CommentProvider
  let formatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named
    formatter.unitsStyle = .short
    return formatter
  }()

  var body: some View {
    VStack(alignment: .leading) {
      HStack() {
        Image(systemName: "person.circle")
          .resizable()
          .aspectRatio(1.0, contentMode: .fit)
          .frame(width: 40)
          .clipShape(Circle())

        VStack(alignment: .leading) {
          Text(comment.createdByUser)
            .font(.headline)
            .foregroundColor(.accentGreen)

          Text(formatter.localizedString(for: comment.createdAt, relativeTo: Date()))
            .font(.caption)
        }

        Spacer()
      }
      Text(comment.caption)
    }
  }
}

struct CommentCell_Previews: PreviewProvider {
  static var previews: some View {
    let activity = Date().advanced(by: TimeInterval(exactly: -5*60)!)
    let comment = "Can you code me up some food?"
    let user = "Jerry"
    let post = Post(caption: comment, createdAt: activity, createdBy: user)
    return CommentCell(comment: post)
      .previewLayout(.sizeThatFits)
  }
}
