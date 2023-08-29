//
//  ClassOpenExample.swift
//  SeSACPhotoFramework
//
//  Created by Alex Cho on 2023/08/29.
//

import Foundation
open class OpenClassExample{
    public static func publicExample(){
        print(#function)
    }
    
    internal static func internalExample(){
        print(#function)
    }
    
    fileprivate static func fileprivateExample(){
        print(#function)
    }
    
    private static func privateExample(){
        print(#function)
    }
}

public class PublicClassExample{
    public static func publicExample(){
        print(#function)
    }
    
    internal static func internalExample(){
        print(#function)
    }
    
    fileprivate static func fileprivateExample(){
        print(#function)
    }
    
    private static func privateExample(){
        print(#function)
    }
}

//Default
class InternalClassExample{
    public static func publicExample(){
        print(#function)
    }
    
    internal static func internalExample(){
        print(#function)
    }
    
    fileprivate static func fileprivateExample(){
        print(#function)
    }
    
    private static func privateExample(){
        print(#function)
    }
}
