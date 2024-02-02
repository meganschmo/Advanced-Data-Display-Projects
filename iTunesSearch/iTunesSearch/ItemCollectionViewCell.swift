//
//  ItemCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Megan Schmoyer on 1/14/24.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell, ItemDisplaying {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
}
