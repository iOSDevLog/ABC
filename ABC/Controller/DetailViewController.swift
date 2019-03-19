//
//  DetailViewController.swift
//  ABC
//
//  Created by iosdevlog on 2019/3/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

private let reuseIdentifier = "DetailCollectionViewCell"

class DetailViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var exam: Exam!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        self.title = String(dformatter.string(from: exam.date))
    }
}

extension DetailViewController: UICollectionViewDataSource {
    
    // MARK: UICollectionViewDataSource
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exam.tests.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DetailCollectionViewCell
        
        // Configure the cell
        let test = exam.tests[indexPath.item]
        cell.charLabel.text = String(test.char)
        cell.testImageView.image = test.isRight ? UIImage(named: "right") : UIImage(named: "wrong")
        
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        
        return CGSize(width: width/5, height: width/5)
    }
}
