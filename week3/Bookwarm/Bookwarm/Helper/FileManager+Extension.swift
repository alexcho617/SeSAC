//
//  FileManager+Extension.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/09/05.
//

import UIKit

extension UIViewController{
    func saveImageToDocument(filename: String, image: UIImage){
        //1 go to doc
        guard let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        //2 make filename
        let fileURL = docDir.appendingPathComponent(filename)
        //3 create image file
        guard let file = image.jpegData(compressionQuality: 0.5) else {return}
        //4 save file
        do {
            try file.write(to: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func deleteFileFromDocument(filename: String){
        guard let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileURL = docDir.appendingPathComponent(filename)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
}
