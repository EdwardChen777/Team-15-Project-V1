//
//  UserRepository.swift
//  Team15-App-V1
//
//  Created by Philip Wellener on 11/9/22.
//

import Foundation
import Combine
import FirebaseFirestore
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift

class UserRepository: ObservableObject {
  private let path: String = "users"
  private let store = Firestore.firestore()

  @Published var profiles: [Profile] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting profiles: \(error.localizedDescription)")
          return
        }

        self.profiles = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Profile.self)
        } ?? []
      }
  }

//  // MARK: CRUD methods
//  func add(_ book: Book) {
//    do {
//      let newBook = book
//      _ = try store.collection(path).addDocument(from: newBook)
//    } catch {
//      fatalError("Unable to add book: \(error.localizedDescription).")
//    }
//  }
//
//  func update(_ book: Book) {
//    guard let bookId = book.id else { return }
//
//    do {
//      try store.collection(path).document(bookId).setData(from: book)
//    } catch {
//      fatalError("Unable to update book: \(error.localizedDescription).")
//    }
//  }
//
//  func remove(_ book: Book) {
//    guard let bookId = book.id else { return }
//
//    store.collection(path).document(bookId).delete { error in
//      if let error = error {
//        print("Unable to remove book: \(error.localizedDescription)")
//      }
//    }
//  }
  
  // MARK: Filtering methods
  func getProfileFor(_ uid: String) -> Profile {
    return self.profiles.filter{$0.uid == uid}.first!
  }
  
}
