//
//  BookInfo.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/08/09.
//

import Foundation
import RealmSwift
class RealmBook: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var authors: String
    @Persisted var title: String
    @Persisted var thumbnail: String
    @Persisted var url: String
    @Persisted var isLiked: Bool = false
    @Persisted var memo: String?
    
    convenience init(authors: String, title: String, thumbnail: String, url: String, isLiked: Bool, memo: String?) {
        self.init()
        self.authors = authors
        self.title = title
        self.thumbnail = thumbnail
        self.url = url
        self.isLiked = isLiked
        self.memo = memo
    }
}
