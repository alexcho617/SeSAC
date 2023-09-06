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
    @Persisted var contents: String
    @Persisted var photo: String?
    @Persisted var isLiked: Bool
    @Persisted var summary: String
    
    convenience init(title: String, date: Date, contents: String, PhotoURL: String? = nil) {
        self.init()
        
        self.title = title
        self.date = date
        self.contents = contents
        self.photo = PhotoURL
        self.isLiked = Bool.random()
        self.summary = "제목은:\(title)  내용은:\(contents)"
    }
}
