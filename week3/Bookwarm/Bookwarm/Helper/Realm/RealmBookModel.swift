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
    @Persisted var thumbnailImageURL: String
    @Persisted var webPageURL: String
    @Persisted var userDidLike: Bool = false
    @Persisted var memo: String?
    
    convenience init(authors: String, title: String, thumbnail: String, url: String, isLiked: Bool, memo: String?) {
        self.init()
        self.authors = authors
        self.title = title
        self.thumbnailImageURL = thumbnail
        self.webPageURL = url
        self.userDidLike = isLiked
        self.memo = memo
    }
}
