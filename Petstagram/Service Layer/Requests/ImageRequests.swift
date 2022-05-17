//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import UIKit
import KituraContracts

struct UploadImageRequest: APIRequest {
  let imageId: UUID
  let imageData: Data

  init(imageId: UUID, imageData: Data) {
    self.imageId = imageId
    self.imageData = imageData
  }

  typealias Response = Void

  var method: HTTPMethod { return .POST }
  var path: String { return "/image" }
  var contentType: String { return "image/jpeg" }
  var additionalHeaders: [String : String] {
    return ["Slug": "\(imageId.uuidString).jpg"]
  }
  var body: Data? {
    return imageData
  }
  var params: EmptyParams? { return nil }

  func handle(response: Data) throws -> Void {
  }
}

struct DownloadImageRequest: APIRequest {
  let imageId: UUID

  init(imageId: UUID) {
    self.imageId = imageId
  }

  typealias Response = UIImage

  var method: HTTPMethod { return .GET }
  var path: String { return "/images/\(imageId.uuidString).jpg" }
  var contentType: String { return "image/jpeg" }
  var additionalHeaders: [String : String] { return [:] }
  var body: Data? { return nil }
  var params: EmptyParams? { return nil }

  func handle(response: Data) throws -> UIImage {
    guard let image = UIImage(data: response) else {
      throw APIError.postProcessingFailed(nil)
    }
    return image
  }
}
