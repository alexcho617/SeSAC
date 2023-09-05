//
//  FileManager+Extension.swift
//  PhotoGramRealm
//
//  Created by Alex Cho on 2023/09/05.
//

import UIKit
extension UIViewController{
    
    func removeImageFromDocument(filename: String){
        //1 go to doc folder
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        //2 append directory + filename
        let fileURL = documentDirectory.appendingPathComponent(filename)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    //get image from the app document folder
    func loadImagFromDocument(filename: String) -> UIImage{
        //1 get doc dir
        guard let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "photo")! } //여기서 에러나면 placeholder image return
        
        //2 get file name
        let fileURL = docDir.appendingPathComponent(filename)
        
        //3 check file existence
        if FileManager.default.fileExists(atPath: fileURL.path()){
            return UIImage(contentsOfFile: fileURL.path())!
        }else {
            return UIImage(systemName: "photo")!
        }
    }
    
    func saveImageToDocument(filename: String, image: UIImage){
        //0 check disk space on device
        //1 go to doc folder
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return} //why use first?
        
        //2 append directory + filename
        let fileURL = documentDirectory.appendingPathComponent(filename)
        
        //3 make image file from uiimage
        guard let data = image.jpegData(compressionQuality: 0.5) else{ return }
        
        //4 save image
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save err", error) //용량이 없다면 에러가 날 수 있다
        }
    }
}
