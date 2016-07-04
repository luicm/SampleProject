//
//  AgendaDatePickerCell.swift
//  SampleProject
//
//  Created by Luisa Cruz Molina on 02/07/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import UIKit

protocol AgendaDatePickerCellDelegate {
    func agendaDatePickerViewDidChangeValue(date:NSDate)
}

class AgendaDatePickerCell: UITableViewCell {

    @IBOutlet weak var datePicker: ColoredDatePicker!
    
    var delegate: AgendaDatePickerCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        datePicker.calendar = NSCalendar.currentCalendar()
        datePicker.minimumDate = NSDate()
        datePicker.tintColor = UIColor.whiteColor()
        self.selectionStyle = .None
    }
    
    @IBAction func datePickerViewDidChangeValue(sender: ColoredDatePicker) {
        delegate?.agendaDatePickerViewDidChangeValue(sender.date)
    }
}

class ColoredDatePicker: UIDatePicker {
    // source: http://stackoverflow.com/questions/29220535/changing-text-color-of-datepicker#29240759
    var changed = false
    override func addSubview(view: UIView) {
        if !changed {
            changed = true
            self.setValue(UIColor.whiteColor(), forKey: "textColor")
        }
        super.addSubview(view)
    }
}
