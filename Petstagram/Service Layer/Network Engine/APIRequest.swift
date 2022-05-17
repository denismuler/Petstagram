//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import Foundation
import KituraContracts

enum HTTPMethod: String {
  case GET
  case POST
  case PUT
  case DELETE
}

struct EmptyParams: QueryParams { }

protocol APIRequest {
  associatedtype Response
  associatedtype QueryParamsType: QueryParams

  var method: HTTPMethod { get }
  var path: String { get }
  var contentType: String { get }
  var additionalHeaders: [String: String] { get }
  var body: Data? { get }
  var params: QueryParamsType? { get }

  func handle(response: Data) throws -> Response
}
