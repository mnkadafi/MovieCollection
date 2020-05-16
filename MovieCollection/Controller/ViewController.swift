//
//  ViewController.swift
//  MovieCollection
//
//  Created by Mochamad Nurkhayal Kadafi on 06/05/20.
//  Copyright © 2020 Manusia Apple. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var collectionViewSingle: UICollectionView!
    @IBOutlet weak var collectionViewTriple: UICollectionView!
    
    var Moviess = [Movie]()
    var Moviess2 = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 130, height: 25))
        btnProfile.setTitle("START PLAYING", for: .normal)
        btnProfile.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnProfile.backgroundColor = UIColor.blue
        btnProfile.layer.cornerRadius = 15
        btnProfile.layer.masksToBounds = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnProfile)
        
        collectionViewSingle.dataSource = self
        collectionViewSingle.delegate = self
        collectionViewTriple.dataSource = self
        collectionViewTriple.delegate = self
        
        callApi(page: "1")
        callApi(page: "2")
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewSingle {
            return Moviess.count
        }else{
            return Moviess2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewSingle {
            let cellSingle = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell

            let endpoint = Moviess[indexPath.row].poster_path
            
            guard endpoint != nil else {
                cellSingle.imageSingle.image = UIImage(named: "joker.jpg")
                return cellSingle
            }
            
            let imageURL = "https://image.tmdb.org/t/p/original/"+endpoint!
            
            AF.download(imageURL).responseData { response in
                if let data = response.value {
                    let image = UIImage(data: data)
                    cellSingle.imageSingle.image = image
                }
            }
            
            cellSingle.labelSingleOne.text = String(describing: Moviess[indexPath.row].popularity!)
            cellSingle.labelSingleTwo.text = Moviess[indexPath.row].title
            cellSingle.labelSIngleThree.text = Moviess[indexPath.row].overview
            
            return cellSingle
        }else{
            let cellTriple = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! Cell

            let endpoint = Moviess2[indexPath.row].poster_path
            
            guard endpoint != nil else {
                cellTriple.imageSingle.image = UIImage(named: "joker.jpg")
                return cellTriple
            }
            
            let imageURL = "https://image.tmdb.org/t/p/original/"+endpoint!
            
            AF.download(imageURL).responseData { response in
                if let data = response.value {
                    let image = UIImage(data: data)
                    cellTriple.imageTriple.image = image
                }
            }
            
            cellTriple.labelTripleOne.text = String(describing: Moviess2[indexPath.row].popularity!)
            cellTriple.labelTripleTwo.text = Moviess2[indexPath.row].title
            cellTriple.labelTripleThree.text = Moviess2[indexPath.row].overview

            cellTriple.btnRounded.layer.cornerRadius = 13
            cellTriple.btnRounded.clipsToBounds = true
            
            return cellTriple
        }
    }
}

extension ViewController{
    func callApi(page : String){
        let requestAPI = Service(baseURL: "https://api.themoviedb.org/3/movie/upcoming?api_key=4c4df43862b1d6323c2cfe8706f39861&language=en-US&page=\(page)")
        requestAPI.getAllData {[weak self] result in
            switch result{
                case .failure(let error):
                    print(error)
                case .success(let movie):
                    
                    if page == "2"{
                        self?.Moviess = movie
                        self?.collectionViewSingle.reloadData()
                    }else{
                        self?.Moviess2 = movie
                        self?.collectionViewTriple.reloadData()
                    }
            }
        }
    }
}
