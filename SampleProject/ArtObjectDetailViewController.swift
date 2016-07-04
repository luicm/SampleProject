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
    @IBOutlet weak var artistNameLabel: UILabel! {
        didSet {
            artistNameLabel.hidden = true
        }
    }
    @IBOutlet weak var physicalMediumLabel: UILabel! {
        didSet {
            physicalMediumLabel.hidden = true
        }
    }

    @IBOutlet weak var yearLabel: UILabel! {
        didSet {
            yearLabel.hidden = true
        }
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.hidden = true
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.hidden = true
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.startAnimating()
        }
    }
    
    
    
    var presenter: ArtObjectDetailPresenter!
    
    var objectId: String?
    
    
    private var artObject: ArtObjectDetail? {
        didSet {
            guard let object = artObject else {return}
            if let imageURL = object.image!.url {
                artImage.kf_setImageWithURL(NSURL(string: imageURL)!,
                                             placeholderImage: nil,
                                             optionsInfo: nil,
                                             progressBlock: { (receivedSize, totalSize) -> () in
                                                print("Download Progress: \(receivedSize)/\(totalSize)")
                    },
                                             completionHandler: { (image, error, cacheType, imageURL) -> () in
                                                self.activityIndicator.stopAnimating()
                    })
            }
            
            artistNameLabel.hidden = false
            artistNameLabel.text = object.principalMakers
            
            physicalMediumLabel.text = object.physicalMedium
            physicalMediumLabel.hidden = false
            
            if let date = object.date {
                yearLabel.text = "\(date)"
                yearLabel.hidden = false
            }
            
            titleLabel.text = object.title
            titleLabel.hidden = false
            descriptionLabel.text = object.labelDescription == nil ? object.description : object.labelDescription
            descriptionLabel.hidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
