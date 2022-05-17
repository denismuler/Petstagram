//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import Foundation
import KituraContracts

struct AddLikeToPostRequest: APIRequest {
  private let like: Like

  init(postId: UUID) {
    like = Like(postId: postId)
  }

  typealias Response = Like

  var method: HTTPMethod { return .POST }
  var path: String { return "/likes" }
  var contentType: String { return "application/json" }
  var additionalHeaders: [String : String] { return [:] }
  var body: Data? {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return try? encoder.encode(like)
  }
  var params: EmptyParams? { return nil }

  func handle(response: Data) throws -> Like {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return try decoder.decode(Response.self, from: response)
  }
}

struct DeleteLikeFromPostRequest: APIRequest {
  private let postId: UUID

  init(postId: UUID) {
    self.postId = postId
  }

  typealias Response = Void

  var method: HTTPMethod { return .DELETE }
  var path: String { return "/likes" }
  var contentType: String { return "application/json" }
  var additionalHeaders: [String : String] { return [:] }
  var body: Data? { return nil }
  var params: LikeParams? {
    return LikeParams(postId: postId.uuidString, createdByUser: currentUser?.id ?? "")
  }

  func handle(response: Data) throws -> Void {
  }
}
