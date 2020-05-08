//
//  ViewController.swift
//  MovieCollection
//
//  Created by Mochamad Nurkhayal Kadafi on 06/05/20.
//  Copyright © 2020 Manusia Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionViewSingle: UICollectionView!
    @IBOutlet weak var collectionViewTriple: UICollectionView!
    
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
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewSingle {
            return Movies.count
        }else{
            return Movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewSingle {
            let cellSingle = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
            cellSingle.imageSingle.image = Movies[indexPath.row].image
            cellSingle.labelSingleOne.text = Movies[indexPath.row].category
            cellSingle.labelSingleTwo.text = Movies[indexPath.row].title
            cellSingle.labelSIngleThree.text = Movies[indexPath.row].subtitle
            
            cellSingle.imageSingle.layer.cornerRadius = 25
            cellSingle.imageSingle.clipsToBounds = true
            
            return cellSingle
        }else{
            let cellTriple = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! Cell
            cellTriple.imageTriple.image = Movies[indexPath.row].image
            cellTriple.labelTripleOne.text = Movies[indexPath.row].category
            cellTriple.labelTripleTwo.text = Movies[indexPath.row].title
            cellTriple.labelTripleThree.text = Movies[indexPath.row].subtitle
            
            cellTriple.imageTriple.layer.cornerRadius = 20
            cellTriple.imageTriple.clipsToBounds = true
            cellTriple.btnRounded.layer.cornerRadius = 13
            cellTriple.btnRounded.clipsToBounds = true
            
            return cellTriple
        }
    }
}

