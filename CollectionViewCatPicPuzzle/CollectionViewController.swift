//
//  PuzzleCollectionViewController.swift
//  CollectionViewCatPicPuzzle
//
//  Created by Joel Bell on 10/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var sectionInsets: UIEdgeInsets!
    var spacing: CGFloat!
    var itemSize: CGSize!
    var referenceSize: CGSize!
    var numberOfRows: CGFloat!
    var numberOfColumns: CGFloat!
    
    var imageSlices: [UIImage] = []
    var headerReusableView: HeaderReusableView!
    var footerReusableView: FooterReusableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "catPuzzleCell")
        self.collectionView?.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        self.collectionView?.register(FooterReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        configureLayout()
        
        for imageCount in 1...12{
            guard let image = UIImage(named: "\(imageCount)") else {return}
            imageSlices.append (image)
        }
        imageSlices = shuffle(imageSlices)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSlices.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catPuzzleCell", for: indexPath) as! CollectionViewCell
        
        cell.imageView.image = imageSlices[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
    func shuffle(_ myArray: [UIImage]) -> [UIImage]{
        var input = myArray
        var output: [UIImage] = []
        let imagesToAppend = input.count
        for _ in 0..<imagesToAppend{
            let rand = Int(arc4random_uniform(UInt32(input.count)))
            output.append (input[rand])
            input.remove(at: rand)
        }
        return output
    }
}

//M--> Conformance to UICollectionViewDelegateFlowLayout, header and footer config
extension CollectionViewController {
    
    func configureLayout () {
        /*This particular grid layout should fit all the reusable views (items(cells), header, footer) inside the dimensions of the screen. The header should be at the top, then the items should form a 3x4 grid, and then the footer should be at the bottom.*/
        let widthBounds = UIScreen.main.bounds.width   //Used in
        let heightBounds = UIScreen.main.bounds.height //extension
        self.numberOfRows = 4
        self.numberOfColumns = 3
        spacing = 2
        sectionInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        referenceSize = CGSize(width: widthBounds, height: 60)
        print ("Bounds: \(widthBounds),\(heightBounds)")
        let itemX:CGFloat = (widthBounds/3 - 3)//((4-1)*2+4)
        let itemY:CGFloat = (heightBounds/4 - 33)  //((3-1)*2+4)
        print ("itemX: \(itemX)    itemY: \(itemY)")
        itemSize = CGSize(width: itemX, height: itemY)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return referenceSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return referenceSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        if kind == UICollectionElementKindSectionHeader {
            
            let headerReusableView = (self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)) as! HeaderReusableView
            
            return headerReusableView
            
        } else {
            
            let footerReusableView = (self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)) as! FooterReusableView
            
            return footerReusableView
        }
        
    }
}





