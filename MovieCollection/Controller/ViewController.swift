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
        
        callApi(page: "3")
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

            let endpoint = Moviess[indexPath.row]
            
            configureCell(urlposter: endpoint, cell: cellSingle, section: "Top")
            
            cellSingle.labelSingleOne.text = String(describing: Moviess[indexPath.row].popularity!)
            cellSingle.labelSingleTwo.text = Moviess[indexPath.row].title
            cellSingle.labelSIngleThree.text = Moviess[indexPath.row].overview
            
            return cellSingle
        }else{
            let cellTriple = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! Cell

            let endpoint = Moviess2[indexPath.row]
            
            configureCell(urlposter: endpoint, cell: cellTriple, section: "Bottom")
            
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
        ServiceAPI.getAllData(page: page) { (movie, error) in
            if page == "2"{
                self.Moviess = movie!
                self.collectionViewSingle.reloadData()
            }else{
                self.Moviess2 = movie!
                self.collectionViewTriple.reloadData()
            }
        }
    }
    
    func configureCell(urlposter: Movie, cell : Cell, section: String){
        guard urlposter.poster_path != nil else {
            switch section {
                case "Top":
                    cell.imageSingle.image = UIImage(named: "joker.jpg")
                case "Bottom":
                    cell.imageTriple.image = UIImage(named: "joker.jpg")
                default:
                    print("Error")
            }
            return
        }
        
        ServiceAPI.getPosterMovie(imageURL: urlposter.poster_path!) { (data) in
            switch section {
                case "Top":
                    cell.imageSingle.image = UIImage.init(data: data)
                case "Bottom":
                    cell.imageTriple.image = UIImage.init(data: data)
                default:
                    print("Error")
            }
        }
    }
}
