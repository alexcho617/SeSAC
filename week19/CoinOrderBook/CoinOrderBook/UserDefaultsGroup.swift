//
//  UserDefaultsGroup.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/30/23.
//

import Foundation


//UD를 사용하는 예제
extension UserDefaults{
    
    
    
    static var groupShared: UserDefaults{
        let appGroupID = "group.com.alexcho617.CoinOrderBook" //오타 안나도록 주의
        return UserDefaults(suiteName: appGroupID)! //그룹 내에 사용 가능한 UD 인스탄스
    }
}
