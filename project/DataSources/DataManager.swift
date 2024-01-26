//
//  DataManager.swift
//  project
//
//  Created by bugra on 17.01.2024.
//

import SwiftUI
import Firebase

// swiftlint:disable identifier_name

final class DataManager: ObservableObject {
    @Published var userInformation: [UserInformation] = []

    static let shared = DataManager()

    init() {
        fetchUserInformation()
    }

    func fetchUserInformation() {
        userInformation.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("UserInformation")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            if let sp = snapshot {
                for doc in sp.documents {
                    let data = doc.data()

                    let userId = data["id"] as? String ?? ""
                    let profileURL = data["profileURL"] as? String ?? ""
                    let favorites = data["favorites"] as? [[String: Any]] ?? []

                    let userInformation = UserInformation(id: userId, profileURL: profileURL, favorites: favorites)
                    self.userInformation.append(userInformation)
                }
            }
        }
    }

    func setUserInformation() async throws {
        let db = Firestore.firestore()
        let ref = db.collection("UserInformation")

        do {
            try await ref.document(Auth.auth().currentUser?.uid ?? "").setData([
                "id": Auth.auth().currentUser?.uid ?? "",
                "profileURL": Auth.auth().currentUser?.photoURL ?? "",
                "favorites": [
                    ["Longitude": 46.690424961696046, "Latitude": 24.744954190042016, "City Name": "Riyad"]
                ]
            ])
            print("Document successfully written!")
        } catch {
            print("Error writing document: \(error)")
        }
    }

    func add(_ data: [String: Any], to field: String) {
        let db = Firestore.firestore()

        guard let actualUserId = Auth.auth().currentUser?.uid else {
            return
        }

        let ref = db.collection("UserInformation").document(actualUserId)

        ref.updateData([
            field: FieldValue.arrayUnion([data])
        ])
    }
}

// swiftlint:enable identifier_name
