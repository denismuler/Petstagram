//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import Foundation

struct GetCommentsForPostRequest: APIRequest {
  private let postId: UUID

  init(postId: UUID) {
    self.postId = postId
  }

  typealias Response = [Comment]

  var method: HTTPMethod { return .GET }
  var path: String { return "/comments" }
  var contentType: String { return "application/json" }
  var additionalHeaders: [String : String] { return [:] }
  var body: Data? { return nil }
  var params: CommentParams? {
    return CommentParams(postId: postId.uuidString)
  }

  func handle(response: Data) throws -> [Comment] {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return try decoder.decode(Response.self, from: response)
  }
}

struct AddCommentToPostRequest: APIRequest {
  private let comment: Comment

  init(postId: UUID, caption: String) {
    self.comment = Comment(postId: postId, caption: caption)
  }

  typealias Response = Comment

  var method: HTTPMethod { return .POST }
  var path: String { return "/comments" }
  var contentType: String { return "application/json" }
  var additionalHeaders: [String : String] { return [:] }
  var body: Data? {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return try? encoder.encode(comment)
  }
  var params: EmptyParams? { return nil }

  func handle(response: Data) throws -> Comment {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return try decoder.decode(Response.self, from: response)
  }
}
