//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import Foundation

struct APIEnvironment {
  var baseUrl: URL
}

extension APIEnvironment {
  static let prod = APIEnvironment(baseUrl: URL(string: "https://134.168.1.08:8010/api/v1")!)
  static let local = APIEnvironment(baseUrl: URL(string: "http://localhost:8080/api/v1")!)
  static let local81 = APIEnvironment(baseUrl: URL(string: "http://localhost:8081/api/v1")!)
}
