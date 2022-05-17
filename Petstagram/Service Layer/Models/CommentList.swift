//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import Foundation
import Combine

class CommentList: ObservableObject {
  @Published var comments: [Comment] = []
  @Published var loadError: Error?
  let postId: UUID
  private var subscriptions: Set<AnyCancellable> = []

  init(forPostId postId: UUID) {
    self.postId = postId
    loadComments()
  }

  func loadComments() {
    let client = APIClient()
    let request = GetCommentsForPostRequest(postId: postId)
    client.publisherForRequest(request)
      .sink(receiveCompletion: { result in
        if case .failure(let error) = result {
          self.loadError = error
        } else {
          self.loadError = nil
        }
      }, receiveValue: { newComments in
        self.comments = newComments
      })
      .store(in: &subscriptions)
  }
}
