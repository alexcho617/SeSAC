//
//  RealmModel.swift
//  PhotoGramRealm
//
//  Created by Alex Cho on 2023/09/04.
//

import Foundation
import RealmSwift

class Diary: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String //나중에 ID로 바꿈
    @Persisted var date: Date
    @Persisted var content: String?
    @Persisted var PhotoURL: String?
    @Persisted var isLiked: Bool
    
    convenience init(title: String, date: Date, content: String? = nil, PhotoURL: String? = nil) {
        self.init()
        
        self.title = title
        self.date = date
        self.content = content
        self.PhotoURL = PhotoURL
        self.isLiked = Bool.random()
    }
}
