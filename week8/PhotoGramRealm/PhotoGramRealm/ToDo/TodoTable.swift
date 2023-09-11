//
//  TodoTable.swift
//  PhotoGramRealm
//
//  Created by Alex Cho on 2023/09/08.
//

import Foundation
import RealmSwift

class TodoTable: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var favorite: Bool
    //One To Many Relationship
    @Persisted var detail: List<DetailTable>
    
    //One to One Relationship: EmbeddedObject(optional 필수)별도 테이블 생성 안됨
    @Persisted var memo: Memo?
    convenience init(title: String, favorite: Bool) {
        self.init()
        self.title = title
        self.favorite = favorite
    }
}

class DetailTable: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var detail: String
    @Persisted var deadline: Date
    
    //Inverse Relationship Property (LinkingObjects) 역관계로 내부 테이블을 외부로 연결
    @Persisted(originProperty: "detail") var mainTodo: LinkingObjects<TodoTable>
    
    convenience init(detail: String, deadline: Date) {
        self.init()
        self.detail = detail
        self.deadline = deadline
    }
}


//one to one, EmbeddedObject 사용
class Memo: EmbeddedObject{
    @Persisted var content: String
    @Persisted var date: Date
}
