//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import SwiftUI
import Combine

struct CommentListView: View {
  var image: UIImage
  private let postId: UUID
  @StateObject var list: CommentList
  @State var newCommentDescription = ""
  @State private var subscriptions: Set<AnyCancellable> = []

  fileprivate init(comments: [Comment], image: UIImage) {
    let newId = UUID()
    let displayList = CommentList(forPostId: newId)
    displayList.comments.append(contentsOf: comments)
    self._list = StateObject(wrappedValue: displayList)
    self.image = image
    self.postId = newId
  }

  init(forPostId postId: UUID, image: UIImage) {
    self._list = StateObject(wrappedValue: CommentList(forPostId: postId))
    self.image = image
    self.postId = postId
  }

  var body: some View {
    VStack(alignment: .leading) {
      ScrollView {
        HStack {
          Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 160)
            .clipped()
          Spacer()
        }

        ForEach(list.comments) { comment in
          CommentCell(comment: comment)
          Divider()
        }
      }

      HStack(spacing: 2) {
        TextField("Add a comment...", text: $newCommentDescription)
          .padding(7)
          .background(Color.paleGrey)
          .clipShape(SelectiveRoundedRectangle(corners: [.topLeft, .bottomLeft], radius: 7))
        Button("Post", action: addComment)
          .padding(8)
          .accentColor(.accentGreen)
          .background(Color.paleGrey)
          .clipShape(SelectiveRoundedRectangle(corners: [.topRight, .bottomRight], radius: 7))
      }
    }
    .padding()
    .navigationBarTitle("Comments")
    .navigationBarTitleDisplayMode(.inline)
  }

  private func addComment() {
    guard newCommentDescription.isEmpty == false else { return }
    let client = APIClient()
    let request = AddCommentToPostRequest(postId: postId, caption: newCommentDescription)
    client.publisherForRequest(request)
      .sink(receiveCompletion: { result in
        if case .finished = result {
          newCommentDescription = ""
        }
      }, receiveValue: {newComment in
        list.comments.append(newComment)
      })
      .store(in: &subscriptions)
  }
}

struct SelectiveRoundedRectangle: Shape {
  let corners: UIRectCorner
  let radius: CGFloat
  func path(in rect: CGRect) -> Path {
    let bPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(bPath.cgPath)
  }
}

struct CommentListView_Previews: PreviewProvider {
  static var previews: some View {
    let postId = UUID()
    let comment1 = Comment(postId: postId, createdBy: "User 1", createdAt: Date(), caption: "Comment 1")
    let comment2 = Comment(postId: postId, createdBy: "User 2", createdAt: Date(), caption: "Comment 2")
    return
      NavigationView {
        CommentListView(comments: [comment1, comment2], image: UIImage(named: "puppies")!)
      }
  }
}
