//
//  MenuView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/13.
//

import SwiftUI

struct MenuView: View {
    
    var cardViewProperty: some View{
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "person")
            Text("사람")
        }
        .background(.green)
        .padding()
        .background(.red)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                CardView(image: "star", text: "Foo")
                CardView(image: "star", text: "Bar")
                CardView(image: "star", text: "Fuz")
                
               
            }
            List {
                Section("섹션1"){
                    Text("1")
                    DatePicker(selection: .constant(Date()), label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                    Text("2")
                    Gauge(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/, in: /*@START_MENU_TOKEN@*/0...1/*@END_MENU_TOKEN@*/) {
                        /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/
                    }
                }
                Section("섹션2"){
                    ColorPicker(/*@START_MENU_TOKEN@*/"Title"/*@END_MENU_TOKEN@*/, selection: .constant(.yellow))
                    Text("4")
                        .modifier(PointBorderText())
                    Text("5").asPointBorderText()
                    Text("6")
                }
            }.listStyle(.inset)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct CardView: View {
    let image: String
    let text: String
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: image)
            Text(text)
                .underline()
        }
        .background(.green)
        .padding()
        .background(.red)
    }
}


struct PointBorderText: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding(10)
            .foregroundColor(.white)
            .background(.purple)
            .clipShape(Circle())
            
    }
    
}

extension View{
    func asPointBorderText() -> some View{
        modifier(PointBorderText())
    }
}
