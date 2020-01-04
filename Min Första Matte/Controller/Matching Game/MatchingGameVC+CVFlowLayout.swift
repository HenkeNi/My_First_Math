//
//  MatchingGameVC+CVFlowLayout.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

// TODO: rename CVDelFlowLayout
extension MatchingGameVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    //    func setCellSize() {
    //
    //        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    //
    //        // Cellsize
    //        let width = (view.frame.width)/2
    //        layout.itemSize = CGSize(width: width, height: width)
    //
    //        // Cell spacing
    //        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 20)
    //        //layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
    //        layout.minimumInteritemSpacing = 2
    //        layout.minimumLineSpacing = 2
    //        collectionView!.collectionViewLayout = layout
    //    }
        
    
//      func addSpacingBetweenCells() {
//          let layout = UICollectionViewFlowLayout()
//          layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//          layout.minimumInteritemSpacing = 2
//          layout.minimumLineSpacing = 2
//          collectionView.collectionViewLayout = layout
//      }
    
}
