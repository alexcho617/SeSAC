//
//  BookRealmRepository.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/09/06.
//

import Foundation
import RealmSwift
protocol RealmRepositoryProtocol{
    func create(_ item: RealmBook)
    func read() -> Results<RealmBook>
    func delete(_ item: RealmBook)
    func update(_ id: ObjectId, title: String, memo: String)
}
class BookRealmRepository: RealmRepositoryProtocol{
    
    
    static let shared = BookRealmRepository()
    private let realm = try! Realm()
    private init() {}
    
    func create(_ item: RealmBook) {
        do {
            try realm.write{
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func read() -> Results<RealmBook> {
        return realm.objects(RealmBook.self)
    }
    
    func update(_ id: ObjectId, title: String, memo: String) {
        do {
            try realm.write{
                realm.create(RealmBook.self, value: [
                    "_id": id,
                    "title": title,
                    "memo": memo
                ] as [String : Any], update: .modified)
                
            }
        } catch {
            print(error)
        }
    }
    
    func delete(_ item: RealmBook) {
        do {
            try realm.write{
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    func getFileURL(){
        print(realm.configuration.fileURL?.description ?? "")
    }
    
    func checkSchemaVersion(){
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
}
