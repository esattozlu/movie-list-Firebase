//
//  MovieDetailVC.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import UIKit

class MovieDetailVC: UIViewController {

    var selectedMovie: Movie?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieYearLbl: UILabel!
    @IBOutlet weak var movieCategoryLbl: UILabel!
    @IBOutlet weak var movieDirectorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedMovie = selectedMovie {
            movieCategoryLbl.text = selectedMovie.kategori
            movieImageView.image = UIImage()
            if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(selectedMovie.film_resim!).png") {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.movieImageView.image = UIImage(data: data!)
                    }
                }
            }
            movieNameLbl.text = selectedMovie.film_ad
            movieDirectorLbl.text = selectedMovie.yonetmen
        }
        
    }

}
