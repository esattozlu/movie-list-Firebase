//
//  DirectorsClass.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import Foundation

class Director {
    var yonetmen_id: Int?
    var yonetmen_ad: String?
    
    init() {
        
    }
    
    init(yonetmen_id: Int, yonetmen_ad: String) {
        self.yonetmen_id = yonetmen_id
        self.yonetmen_ad = yonetmen_ad
    }
}
