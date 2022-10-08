//
//  MoviesVC.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import UIKit
import Firebase

class MoviesVC: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    var movieList = [Movie]()
    var selectedCategory: Category?
    var reference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self

        
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.movieCollectionView.frame.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cellWidth = (width-30)/2
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 10
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.7)
        
        movieCollectionView.collectionViewLayout = design
        
        if let selectedCategory = selectedCategory {
            navigationItem.title = selectedCategory.kategori_ad
            getMoviesByCategoryName(category_name: selectedCategory.kategori_ad!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = sender as? Int {
            let selectedMovie = movieList[index]
            let destinationVC = segue.destination as! MovieDetailVC
            destinationVC.selectedMovie = selectedMovie
        }
    }
    
    func getMoviesByCategoryName(category_name: String) {
        let newReference = reference.child("filmler").queryOrdered(byChild: "kategori_ad").queryEqual(toValue: category_name)
        newReference.observe(.value) { snaphot in
            if let movies = snaphot.value as? [String:AnyObject] {
                self.movieList.removeAll()
                for movie in movies {
                    if let dictionary = movie.value as? NSDictionary {
                        let key = movie.key
                        let movie_name = dictionary["film_ad"] as? String ?? ""
                        let movie_year = dictionary["film_yil"] as? Int ?? 0
                        let movie_img = dictionary["film_resim"] as? String ?? ""
                        let category = dictionary["kategori_ad"] as? String ?? ""
                        let director = dictionary["yonetmen_ad"] as? String ?? ""
                        
                        let mov = Movie(film_id: key, film_ad: movie_name, film_yil: movie_year, film_resim: movie_img, kategori: category, yonetmen: director)
                        self.movieList.append(mov)
                    }
                    
                }
            }
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
            
        }
    }

}

extension MoviesVC: UICollectionViewDelegate, UICollectionViewDataSource, MoviesCollectionCellProtocol {
    
    func addToCart(indexPath: IndexPath) {
        print("to Cart added movie: \(movieList[indexPath.row].film_ad!)")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movieList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCollectionCell", for: indexPath) as! MoviesCollectionCell
        cell.movieImageView.image = UIImage()
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(movie.film_resim!).png") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.movieImageView.image = UIImage(data: data!)
                }
            }
        }
        cell.movieNameLabel.text = movie.film_ad
        cell.moviePriceLabel.text = "15.99₺"
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.5
        
        cell.cellProtocol = self
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: indexPath.row)
    }
    
    
}
