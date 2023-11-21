//
//  OverlayView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/21.
//

import SwiftUI

struct OverlayView: View {
    var body: some View {
        VStack{
            ZStack {
                Circle()
                    .fill(.yellow)
                .frame(width: 150, height: 150)
                Text("Hello Worlddddddasdasdasdaasdsadasdasdawdasdawdsawdskjfhhskuahadkuwhajskakduwjsjadkuhefksuehfkjdfkushefkjdhsfkuhefkuhesfkuhsefkuhsekfuhsekfuh")
            }
            Circle()
                .fill(.yellow)
                .frame(width: 150, height: 150)
                .overlay {
                    Text("Hello Worlddddddasdasdasdaasdsadasdasdawdasdawdsawdskjfhhskuahadkuwhajskakduwjsjadkuhefksuehfkjdfkushefkjdhsfkuhefkuhesfkuhsefkuhsekfuhsekfuh")
                }
        }
    }
}

struct OverlayView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayView()
    }
}
