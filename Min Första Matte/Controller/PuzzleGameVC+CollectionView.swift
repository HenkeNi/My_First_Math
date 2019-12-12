//
//  PuzzleGameVC+CollectionView.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-10-04.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension PuzzleGameVC: UICollectionViewDataSource, UICollectionViewDelegate {
    

    // Returns amount of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
     }
    
    
     // Returns what a cell contains
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "puzzleCell", for: indexPath) as! PuzzleCell
         
         cell.puzzleImage.image = UIImage(named: images[indexPath.row])
         return cell
     }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(images[indexPath.row])
        
        let firstCard = images[indexPath.row]
        //let secondCard =
        
        //puzzleCollectionView.moveItem(at: <#T##IndexPath#>, to: <#T##IndexPath#>)
        
    }
    
    /*
    // Set size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (puzzleCollectionView.frame.width / 3)
        return CGSize(width: width, height: width)
         

        /*let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 1
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: dim, height: dim)*/
        
        
        
        
        
        /*let cellsInRow = 3
        
        let flowaLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowaLayout.sectionInset.left
            + flowaLayout.sectionInset.right
            + (flowaLayout.minimumInteritemSpacing * CGFloat(cellsInRow - 1))
        
        let size = Int ((collectionView.bounds.width - totalSpace) / CGFloat (cellsInRow))
        
        return CGSize(width: size, height: size)*/
        
        /*let width = collectionView.bounds.width/3.0
        let height = width;
        
        return CGSize(width: width, height: height)*/
    }*/
    
    
    
    
    
   /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }*/
    
    

    
    
}
