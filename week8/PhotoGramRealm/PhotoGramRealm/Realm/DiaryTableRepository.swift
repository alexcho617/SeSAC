//
//  DiaryTableRepository.swift
//  PhotoGramRealm
//
//  Created by Alex Cho on 2023/09/06.
//

import Foundation
import RealmSwift

//테이블이 여러개 있는 경우 프로토콜 활용
protocol DiaryTableRepositoryType: AnyObject {
    func fetch() -> Results<Diary>
    func fetchFilter() -> Results<Diary>
    func create(_ diary: Diary)
}

class DiaryTableRepository: DiaryTableRepositoryType{
    private let realm = try! Realm()
    
    func create(_ diary: Diary){
        do {
            try realm.write{
                realm.add(diary)
            }
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<Diary> {
        realm.objects(Diary.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    //함수를 더 만들어도 되고 아니면 매개변수를 활용해도 된다
    //선필터 후 정렬이 좋다
    func fetchFilter() -> Results<Diary> {
        let result = realm.objects(Diary.self).where {
           
            $0.photo != nil
        }
        return result
    }
    
    func update(id: ObjectId, title: String, contents: String) {
        do {
            try realm.write{
//                realm.add(item, update: .modified)
                realm.create(Diary.self, value: ["_id": id, "title": title, "content": contents] as [String : Any], update: .modified)
            }
        } catch let error {
            print(error)
        }
    }
    
    
    func fileURL(){
        print(realm.configuration.fileURL?.description ?? "")
    }
    
    //schema version check
    func checkSchemaVersion(){
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
}
