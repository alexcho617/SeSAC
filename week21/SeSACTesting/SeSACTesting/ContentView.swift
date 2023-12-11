//
//  ContentView.swift
//  SeSACTesting
//
//  Created by Alex Cho on 12/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var emailText = ""
    @State private var idText = ""
    @State private var passwordText = ""
    
    @State private var isSheetPresented = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(emailText)
            Text(idText)
            Text(passwordText)
            TextField("이메일을 입력해주세요", text: $emailText)
                .font(.title)
                .accessibilityIdentifier("emailTextField")
                .accessibilityLabel("이메일 기입란")
            TextField("아이디를 입력해주세요", text: $idText)
                .accessibilityIdentifier("idTextField")
            TextField("비밀번호를 입력해주세요", text: $passwordText)
                .accessibilityIdentifier("passwordTextField")
            Button("Login") {
                isSheetPresented.toggle()
            }
            .accessibilityIdentifier("loginButton")
        }
        .padding()
        .sheet(isPresented: $isSheetPresented, content: {
            NextView()
        })
    }
}


struct NextView: View {
    var body: some View {
        Text("Logged In")
    }
}

#Preview {
    ContentView()
}
