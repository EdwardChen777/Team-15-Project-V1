

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

struct Profile {
  let db = Firestore.firestore()
  
  var user_id: String
  var docRef: AnyObject

  init(user_id: String) {
    self.user_id = user_id
    self.docRef = db.collection("users").document(user_id)
  }
  
  func getName() -> String {
    
//    return self.docRef.firstname + " " + self.docRef.lastname
    return ""
  }
  
  func getEmail() -> String {
    
//    return self.user_id.email
    return ""
  }
  
  func getPhone() -> String {
    
//    return phone
    return ""
  }
  
  
  
  
}
