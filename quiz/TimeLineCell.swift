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
    
    func setText(name:String,title:String,num:Int){
        self.nameLabel.text = name
        self.titleLabel.text = title
        self.numberLabel.text = num.description
    }

}
