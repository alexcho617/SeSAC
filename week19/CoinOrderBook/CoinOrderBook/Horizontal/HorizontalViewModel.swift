//
//  HorizontalViewModel.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/27/23.
//

import SwiftUI

class HorizontalViewModel: ObservableObject {
    @Published var value = 0.0
    func timer(){
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            self.value += 0.5
        }
    }
}
