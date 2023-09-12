//
//  PhotoViewModel.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/12.
//

import Foundation

class PhotoViewModel{
    var list = Observable(Photo(total: 0, total_pages: 0, results: []))
    var numberOfRowsInSection: Int {
        return list.value.results?.count ?? 0
    }
    func fetchPhoto(){
        APIService.shared.searchPhoto(query: "sky") { photo in
            guard let photo = photo else {return}
            self.list.value = photo
        }
    }
    func cellForRowAt(_ indexPath: IndexPath) -> PhotoResult{
        return list.value.results![indexPath.row]
    }
    
}
