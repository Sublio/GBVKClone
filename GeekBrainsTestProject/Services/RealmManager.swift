//
//  RealmManager.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 15.04.2021.
//

import RealmSwift
import Foundation

class RealmManager {

    static let shared = RealmManager()

    private init () {}

    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    func createFriendsDB(friends: [Friend]) {

        for friend in friends {
            do {
                let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
                let realm = try Realm(configuration: configuration)
                try realm.write({
                    realm.add(friend, update: .all)
                })
            } catch {
                print(error)
            }
        }
    }

    func createGroupsDB(groups: [Group]) {
        for group in groups {
            do {
                let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
                let realm = try Realm(configuration: configuration)
                try realm.write({
                    realm.add(group, update: .all)
                })
            } catch {
                print(error)
            }
        }
    }

    func createSearchableGroupsDB(groups: [SearchableGroup]) {
        for group in groups {
            do {
                let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
                let realm = try Realm(configuration: configuration)
                try realm.write({
                    realm.add(group, update: .all)
                })
            } catch {
                print(error)
            }
        }
    }

    func deleteDatabase() {
        let realm = try! Realm(configuration: configuration)
        try! realm.write {
            realm.deleteAll()
        }
    }

    func delete<T: Object>(selectedType: T.Type) {
        let realm = try! Realm(configuration: configuration)
        try! realm.write {
            let object = realm.objects(selectedType)
            realm.delete(object)
        }
    }

    func delete<T: Object>(selectedType: T.Type, index: Int) {
        let realm = try! Realm(configuration: configuration)
        try! realm.write {
            let object = realm.objects(selectedType)
            realm.delete(object[index])
        }
    }

    func add<T: Object>(_ selectedObject: T) {
        let realm = try! Realm(configuration: configuration)
        do {
            try realm.write {
                realm.add(selectedObject)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func getArray<T: Object>(selectedType: T.Type) -> [T] {
        let realm = try! Realm(configuration: configuration)
        let object = realm.objects(selectedType)
        var array = [T]()
        for data in object {
            array.append(data)
        }
        return array
    }

    func getObject<T: Object>(selectedType: T.Type, index: Int) -> T {
        let realm = try! Realm(configuration: configuration)
        let object = realm.objects(selectedType)
        var array = [T]()
        for data in object {
            array.append(data)
        }
        return array[index]
    }

    func getObjects<T: Object>(selectedType: T.Type) ->Results<T>? {
        let realm = try! Realm(configuration: configuration)
        let objects = realm.objects(selectedType)
        return objects
    }

    func getFriendInfoById(id: Int) -> Friend? {
        let realm = try! Realm()
        return realm.object(ofType: Friend.self, forPrimaryKey: id)
    }

    func updatePhotosStorageForFriend(friendId: Int, photo: Photo) {
        let realm = try! Realm()
        let user = realm.object(ofType: Friend.self, forPrimaryKey: friendId)
        try! realm.write({
            user?.friendPhotos.append(photo)
        })
    }

    // return Result tyle
    func getResults<T: Object>(selectedType: T.Type) -> Results<T> {
        let realm = try! Realm(configuration: configuration)
        return realm.objects(selectedType)
    }

    func getResult<T: Object>(selectedType: T.Type) -> T? {
        let realm = try! Realm(configuration: configuration)
        return realm.objects(selectedType).first
    }
}
