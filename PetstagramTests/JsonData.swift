//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import Foundation

enum JsonData {
  static let goodFeed = """
          [
            {
              "id": "210B9863-F7CC-4298-BA78-2A6C73D7D002",
              "createdAt": "2020-04-01T12:00:00Z",
              "caption": "Living her best life! #corgi #puppyStyle",
              "createdByUser": "corgistuff"
            },
            {
              "id": "144C56D1-F4D8-4BD2-8C9F-AAB87BA8B1C6",
              "createdAt": "2020-03-11T04:44:00Z",
              "caption": "Bath time is best time!",
              "createdByUser": "petcare47"
            },
            {
              "id": "823DE4BB-7FE9-41E6-A72E-208A6A6C5662",
              "createdAt": "2020-01-03T17:32:00Z",
              "caption": "Not sure if alien or dog...",
              "createdByUser": "truthisoutthere"
            }
          ]
          """

  static let badJson = """
    [
      "bad json"
    ]
    """

  static let goodSignUp = """
    {
      "username": "username",
      "email": "email@example.com"
    }
    """

  static let postUploaded = """
    {
      "id": "7D1EA5FA-3BB0-4CE4-AADB-DCCA549D3F51",
      "createdAt": "2020-09-03T12:00:00Z",
      "caption": "Dummy description",
      "createdByUser": "Jerry"
    }
    """
}
