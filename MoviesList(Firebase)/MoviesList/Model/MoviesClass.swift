//
//  MoviesClass.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import Foundation

class Movie {
    var film_id: String?
    var film_ad: String?
    var film_yil: Int?
    var film_resim: String?
    var kategori: String?
    var yonetmen: String?
    
    init() {
        
    }
    
    init(film_id: String, film_ad: String, film_yil: Int, film_resim: String, kategori: String, yonetmen: String) {
        self.film_id = film_id
        self.film_ad = film_ad
        self.film_yil = film_yil
        self.film_resim = film_resim
        self.kategori = kategori
        self.yonetmen = yonetmen
    }
    
}
