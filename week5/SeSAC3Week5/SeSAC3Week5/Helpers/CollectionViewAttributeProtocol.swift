//
//  CollectionViewAttributeProtocol.swift
//  SeSAC3Week5
//
//  Created by Alex Cho on 2023/08/17.
//

import Foundation

protocol CollectionViewAttributeProtocol{
    func configureCollectionView()
    func configureCollectionViewLayout()
}

//여기서 익스텐션해서 메소드 만들고 다른 뷰컨에서 오버라이드해서 실행하고 부모껏도 호출하면 어떤가?
