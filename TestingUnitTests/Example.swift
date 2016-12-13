//
//  Example.swift
//  TestingUnitTests
//
//  Created by Ievgen Keba on 12/12/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import Foundation

class Example {
    
    static let dictionaryKeyName = "name"
    static let dictionaryKeyDestructivePower = "destruction"
    static let dictionaryKeyMotivation = "motivation"
    
    static let minDestructivePower = 0
    static let maxDestructivePower = 4
    static let minMotivation = 0
    static let maxMotivation = 4
    
    var name: String = ""
    var destructivePower: Int = 2
    var motivation: Int = 2
    var rating: Int {
        get {
            return (destructivePower + motivation) / 2
        }
    }
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let name = dictionary[Example.dictionaryKeyName] as? String, name.characters.count > 0 else {
            return nil
        }
        
        guard let destructivePower = dictionary[Example.dictionaryKeyDestructivePower] as? Int, destructivePower >= Example.minDestructivePower
            && destructivePower <= Example.maxDestructivePower else {
                return nil
        }
        
        guard let motivation = dictionary[Example.dictionaryKeyMotivation] as? Int, motivation >= Example.minMotivation
            && motivation <= Example.maxMotivation else {
                return nil
        }
        
        self.name = name
        self.destructivePower = destructivePower
        self.motivation = motivation
    }
}
