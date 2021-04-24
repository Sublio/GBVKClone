//
//  FireStorageMananger.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.04.2021.
//

import Foundation
import Firebase

class FireStorageManager {

    let dbReferenceURL: String = "https://geekbrainstestproject-default-rtdb.europe-west1.firebasedatabase.app/"

    var ref: DatabaseReference!
    var currentUserId: String?

    static let shared = FireStorageManager()

    private init () {

        self.ref = Database.database().reference(fromURL: dbReferenceURL)
    }

    func getAllData() {
        self.ref.child("Users").getData { (error, snapshot) in
            if let error = error {
                print(error)
            } else if snapshot.exists() {
                print(snapshot.value!)
            } else {
                print("No data available")
            }
        }
    }

    func writeUserIdToFireStore(userId: String) {
        guard let dbRef = self.ref?.child("Users") else { return }
        // dbRef.child(userId).setValue(["Group1", "Group2", "Group 3"])
        self.currentUserId = userId
        dbRef.setValue(userId)
    }

    func writeSearchedGroupsForCurrentUser(groups: [SearchableGroup]) {
        guard let dbRef = self.ref?.child("Users") else { return }
        guard let currentUserId = self.currentUserId else { return }
        let groupNames = groups.map {$0.name}
        dbRef.child(currentUserId).child("Groups").setValue(groupNames)
    }
}
