//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//
import SwiftUI

struct FeedView: View {
  @StateObject var feed = Feed()

  var body: some View {
    NavigationView {
      List {
        ForEach(feed.posts.indices, id: \.self) { index in
          FeedCell(post: $feed.posts[index])
        }
      }
      .navigationBarHidden(true)
    }
  }
}

struct FeedView_Previews: PreviewProvider {
  static var previews: some View {
    let feed = Feed()
    for index in 1...5 {
      feed.posts.append(Post(id: UUID(), caption: "Caption \(index)", createdAt: Date(), createdBy: "User \(index)"))
    }
    return FeedView(feed: feed)
  }
}
