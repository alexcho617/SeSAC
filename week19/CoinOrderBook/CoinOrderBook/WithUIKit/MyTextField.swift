//
//  MyTextField.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/27/23.
//

import SwiftUI

struct MyTextField: UIViewRepresentable{
   
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.borderStyle = .none
        view.keyboardType = .numberPad
        view.tintColor = .red
        view.font = .boldSystemFont(ofSize: 20)
        view.text = text
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    
    //UIKit -> SwiftUI 사용자에게로부터 입력 받은 값을 제어하려고 함
    //UIKit Textfield 대한 타이밍에 대한 제어, UIKit 기능을 사용할 때 필요
    class Coordinator: NSObject, UITextFieldDelegate{
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text //바인딩 내에 스트링에다가 데이터를 넣기 위해 _를 썼는데 이걸 뭐라고 하나?
        }
        
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //enter를 눌렀을때 텍스트를 반영해보기
            text = textField.text ?? ""
            return true
        }
    }
}
