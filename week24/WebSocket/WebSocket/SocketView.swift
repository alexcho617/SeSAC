//
//  SocketView.swift
//  WebSocket
//
//  Created by Alex Cho on 12/26/23.
//

import SwiftUI

struct SocketView: View {
    @StateObject
    private var viewModel = SocketViewModel()
    var body: some View {
        VStack{
            ForEach(viewModel.askOrderBook){_ in 
                Text($)
            }
        }
    }
}

#Preview {
    SocketView()
}
