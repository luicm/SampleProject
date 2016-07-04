//
//  EventCell.swift
//  SampleProject
//
//  Created by Luisa Cruz Molina on 02/07/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import UIKit

protocol EventCellDelegate {
    func didTapLearnMoreButton(url:String)
    func didTapGetTicketsButton(url:String)
}

class EventCell: UITableViewCell {

    var delegate: EventCellDelegate?
    
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var learnMoreButton: UIButton! {
        didSet {
            styleButton(learnMoreButton)
        }
    }
    
    @IBOutlet weak var getTicketsButton: UIButton! {
        didSet {
            styleButton(getTicketsButton)
        }
    }
    
    private var learnMoreURL:String?
    private var getTicketsURL:String?

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(event event: Event) {
        eventType.text = event.expositionType
        eventName.text = event.name
        typeLabel.text = event.groupType
        if let remaining = event.remaining {
            availabilityLabel.text = "\(remaining)"
        }
        if let price = event.price {
            priceLabel.text = "\(price) €"
        }
        learnMoreURL = event.descriptionURL
        getTicketsURL = event.ticketsURL
        
        self.selectionStyle = .None
    }

    @IBAction func learnMoreButtonTapped(sender: UIButton) {
        
        delegate?.didTapLearnMoreButton(learnMoreURL!)
        styleButton(sender)
    }
    
    @IBAction func getTicketsButtonTapped(sender: UIButton) {
        
        delegate?.didTapGetTicketsButton(getTicketsURL!)
        styleButton(sender)
    }
    
    @IBAction func buttonReleased(sender: UIButton) { //Touch Down action
        
        styleButtonPressed(sender)
    }
    
    func styleButton(button: UIButton) {
        
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
    }
    
    func styleButtonPressed(button: UIButton) {
        
        button.layer.borderColor = UIColor(hue:0.11, saturation:0.67, brightness:0.96, alpha:1.00).CGColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
    }
}
