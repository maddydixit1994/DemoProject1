//
//  ColorfulTableViewCell.swift
//  DemoProject
//
//  Created by Revonomics on 05/10/18.
//  Copyright © 2018 Revonomics. All rights reserved.
//

import UIKit

class ColorfulTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("cell initialization...")
        setupGraphic()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupGraphic() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.cardView.backgroundColor = .white
        self.cardView.layer.cornerRadius = 10
    }
}
