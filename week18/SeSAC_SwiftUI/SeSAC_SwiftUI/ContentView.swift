//
//  ContentView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/13.
//

import SwiftUI

struct ContentView: View {
    //some: Opaque type(5.1) 역제네릭 타입, 사용하기 전에 이미 타입을 알지만 너무 복잡해서 숨긴다.
    var body: some View{
        //1. modifier
        //2. view returns everytime
        //3. modifier순서 중요
        
        
        Button("Its my button") {
            let value = type(of: self.body)
            print(value)
            print("JOLEY")
        }
        .foregroundStyle(.yellow) //이게 추가되면 리턴 타입이 some view가 되어버린다.
        .background(.green)
        .border(.blue,width: 2)
        .border(Color.black)
//        .clipShape(Circle())
        
        Button("Its my button") {
            let value = type(of: self.body)
            print(value)
            print("JOLEY")
        }
        .foregroundStyle(.yellow) //이게 추가되면 리턴 타입이 some view가 되어버린다.
        .background(.green)
        .border(.blue,width: 2)
        .border(Color.black)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
