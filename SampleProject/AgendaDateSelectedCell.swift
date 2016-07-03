//
//  AgendaDateSelectedCell.swift
//  SampleProject
//
//  Created by Luisa Cruz Molina on 02/07/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import UIKit

class AgendaDateSelectedCell: UITableViewCell {

    @IBOutlet weak var dateSelectedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .None
    }

    func setDate(date: NSDate) {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = NSTimeZone(name: "GMT")
        
        dateSelectedLabel.text = formatter.stringFromDate(date)
    }
}
