//
//  TimeLineCell.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/13.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

class TimeLineCell: UITableViewCell {

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var numberLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(name:String,title:String,num:Int){
        self.nameLabel.text = name
        self.titleLabel.text = title
        self.numberLabel.text = num.description
        self.selectionStyle = UITableViewCellSelectionStyle.Default
        self.backgroundColor = UIColor.clearColor()
        self.layer.borderWidth = 0.12
        self.layer.borderColor = UIColor.blackColor().CGColor
        
        let endColor = UIColor(red:0.68, green:0.68, blue:0.68, alpha:1)
        let middleColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1)
        let gradientColors: [CGColor] = [endColor.CGColor, middleColor.CGColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, atIndex: 0)
        
    }

}
