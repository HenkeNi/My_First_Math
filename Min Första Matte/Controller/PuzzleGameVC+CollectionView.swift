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
        //return images.count
        return puzzlePieces?.pieces.count ?? 0
        
//        if let puzzlePieces = puzzlePieces?.pieces.count {
//            return puzzlePieces
//        }
//        return 0 // TODO: return current puzzle size?
//        
     }
    
    
     // Returns what a cell contains
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "puzzleCell", for: indexPath) as! PuzzleCell
         
         //cell.puzzleImage.image = UIImage(named: images[indexPath.row])
        
        if let puzzlePieceImg = puzzlePieces?.pieces[indexPath.row].imageName {
            cell.puzzleImage.image = UIImage(named: puzzlePieceImg)
        }
        
        if let puzzlePieces = puzzlePieces?.pieces {
            
            for piece in puzzlePieces {
                setPuzzlePiecePosition(position: indexPath.row, puzzlePiece: piece)
            }
        }
        
        return cell
     }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //print(puzzlePieces?.pieces[indexPath.row].imageName)
        //print(images[indexPath.row])
        //print("\(indexPath.row)")
        
        
        // FIX!! Optionals!!
        if puzzlePieces?.firstPiece == nil {
            
            puzzlePieces?.firstPiece = indexPath.row
            
            
        } else {
            puzzlePieces?.secondPiece = indexPath.row
            puzzlePieces?.pieces.swapAt(puzzlePieces!.firstPiece!, puzzlePieces!.secondPiece!)
            
                // BEHÖVS???
            
            puzzlePieces?.firstPiece = nil
            puzzlePieces?.secondPiece = nil
            
            puzzleCollectionView.reloadData()
            
            checkForCompletion()
            // CHECK IF ALL PIECES ARE CORRECT
        }
        
        print(indexPath.row)
        puzzlePieces?.pieces[indexPath.row].currentPosition = indexPath.row
        //print(puzzlePieces?.pieces[indexPath.row].currentPosition)
        //print(puzzlePieces?.pieces[indexPath.row].indexPosition)
//        if firstCardIndex == 10 {
//            firstCardIndex = indexPath.row
//        } else {
//            images.swapAt(firstCardIndex, indexPath.row)
//            firstCardIndex = 10
//            puzzleCollectionView.reloadData()
//        }
//
//
//        let firstCard = images[indexPath.row]
//        //let secondCard =
//
//        //puzzleCollectionView.moveItem(at: <#T##IndexPath#>, to: <#T##IndexPath#>)
        
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
    
    
    func setCellSize() {
        let itemSize = puzzleCollectionView.frame.size.width / 4
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        puzzleCollectionView.collectionViewLayout = layout
    }
    
    
}
