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
  let userProfile = Profile(user_id: Auth.auth().currentUser!.uid)
  
    var body: some View {
      VStack {
        Text("Account Information").font(.title)
        List {
          HStack{
            Text("Name:")
            Spacer()
//            Text(userInfo?.name ?? "John Smith").foregroundColor(.gray)
            Text(userProfile.getName()).foregroundColor(.gray)
          }
          HStack{
            Text("Email:")
            Spacer()
            Text(userProfile.getEmail()).foregroundColor(.gray)
          }
          HStack{
            Text("Phone Number:")
            Spacer()
            Text(userProfile.getPhone()).foregroundColor(.gray)
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
