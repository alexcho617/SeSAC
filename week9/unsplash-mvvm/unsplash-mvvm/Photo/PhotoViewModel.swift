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
    func fetchPhoto(text: String){
        APIService.shared.searchPhoto(query: text) { photo in
            
            //MARK: 통신 후 메인에서 UI 처리
            DispatchQueue.main.async {
                guard let photo = photo else {return}
                self.list.value = photo
                dump(self.list)
            }
            
        }
    }
    
    func cellForRowAt(_ indexPath: IndexPath) -> PhotoResult{
        return list.value.results![indexPath.row]
    }
    
}
