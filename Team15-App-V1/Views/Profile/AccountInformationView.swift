//
//  AccountInformationView.swift
//  Team15-App-V1
//
//  Created by Philip Wellener on 11/6/22.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseCore

struct AccountInformationView: View {
  @ObservedObject var profiles = UserRepository()
//  let currentUser: FirebaseAuth.User
//  let authProfile: Profile
  
  let currentUser = Auth.auth().currentUser!
  
//  var authProfile = profiles.getProfileFor(currentUser.uid)
  
//  init () {
//    self.currentUser = Auth.auth().currentUser!
//    self.authProfile = profiles.getProfileFor(self.currentUser.uid)
//  }
  
  
  
  
//  let currentUser = Auth.auth().currentUser!
//  let authProfile = profiles.getProfileFor(currentUser.uid)
//
    var body: some View {
      var authProfile = profiles.getProfileFor(currentUser.uid)
      VStack {
        Text("Account Information").font(.title)
        List {
          HStack{
            Text("Name:")
            Spacer()
            Text(authProfile.firstname + " " + authProfile.lastname ?? "John Smith").foregroundColor(.gray)
//            Text(userProfile.getName()).foregroundColor(.gray)
          }
          HStack{
            Text("Email:")
            Spacer()
            Text(currentUser.email ?? "No email on file").foregroundColor(.gray)
          }
          HStack{
            Text("Phone Number:")
            Spacer()
            Text(authProfile.phone_number ?? "No phone number on file").foregroundColor(.gray)
          }
        }
      }
    }
}

struct AccountInformationView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInformationView()
    }
}
