//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import Foundation

struct Post: Codable, Identifiable, CommentProvider {
  var id: UUID?
  var caption: String
  var createdAt: Date
  var createdByUser: String
  var isLiked: Bool = false

  init(id: UUID? = nil, caption: String, createdAt: Date = Date(), createdBy: String = currentUser?.id ?? "") {
    self.id = id
    self.createdByUser = createdBy
    self.createdAt = createdAt
    self.caption = caption
  }
}
