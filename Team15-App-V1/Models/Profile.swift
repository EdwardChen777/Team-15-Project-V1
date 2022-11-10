//
//  Profile.swift
//  Team15-App-V1
//
//  Created by Philip Wellener on 11/7/22.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseCore


struct Profile: Codable {
  
  var firstname: String
  var lastname: String
  var phone_number: String
  var uid: String
  
  enum CodingKeys: String, CodingKey {
    case firstname
    case lastname
    case phone_number
    case uid
  }
  
}
