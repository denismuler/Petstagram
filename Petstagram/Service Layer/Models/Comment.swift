//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import Foundation
import KituraContracts

protocol CommentProvider {
  var createdByUser: String { get }
  var createdAt: Date { get }
  var caption: String { get }
}

struct Comment: Codable, Identifiable, CommentProvider {
  var id: UUID?
  var postId: UUID
  var createdByUser: String
  var createdAt: Date
  var caption: String

  init(id: UUID? = nil, postId: UUID, createdBy: String = currentUser?.id ?? "", createdAt: Date = Date(), caption: String) {
    self.id = id
    self.postId = postId
    self.createdByUser = createdBy
    self.createdAt = createdAt
    self.caption = caption
  }
}

struct CommentParams: QueryParams {
  var postId: String
}
