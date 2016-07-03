//
//  ArtObjectDetailViewController.swift
//  SampleProject
//
//  Created by Luisa Qardio on 01/07/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import UIKit
import Kingfisher
import GSImageViewerController

class ArtObjectDetailViewController: UIViewController {

    @IBOutlet weak var artImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var physicalMediumLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter: ArtObjectDetailPresenter!
    
    var objectId: String?
    
    
    private var artObject: ArtObjectDetail? {
        didSet {
            guard let object = artObject else {return}
            if let imageURL = object.image!.url {
                artImage.kf_setImageWithURL(NSURL(string: imageURL)!)
            }
            artistNameLabel.text = object.principalMakers
            physicalMediumLabel.text = object.physicalMedium
            if let date = object.date {
                yearLabel.text = "\(date)"
            }
            titleLabel.text = object.title
            descriptionLabel.text = object.labelDescription == nil ? object.description : object.labelDescription
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ArtObjectDetailPresenter(delegate: self, objectId: objectId!)
    }
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        let imageInfo   = GSImageInfo(image: artImage.image!, imageMode: .AspectFit)
        let transitionInfo = GSTransitionInfo(fromView: artImage)
        let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
        presentViewController(imageViewer, animated: true, completion: nil)
    }
}

extension ArtObjectDetailViewController: ArtObjectDetailPresenterDelegate {
    
    // MARK: - ArtObjectDetailPresenterDelegate
    
    func didUpdateArtObjectDetail(object: ArtObjectDetail) {
        artObject = object
    }
}
