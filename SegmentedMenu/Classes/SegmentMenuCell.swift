//
//  SegmentMenuCell.swift
//  Page
//
//  Created by Quan on 08/07/2022.
//

import UIKit

class SegmentMenuCell: UICollectionViewCell {
    
    static let identifer = "SegmentMenuCell"
    static func nib() -> UINib{
        return UINib(nibName: "SegmentMenuCell", bundle: SegmentedMenu.getBundle())
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var badgeView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
