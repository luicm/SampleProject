//
//  CollectionListViewController.swift
//  SampleProject
//
//  Created by Luisa Qardio on 30/06/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import UIKit
import Kingfisher


class CollectionListViewController: UICollectionViewController {
    
    var presenter: CollectionListPresenter!
    
    private var artObjects: [ArtObject]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    private var artObjectID: String?
    
    required init?(coder aDecoder: NSCoder) {
       
        super.init(coder: aDecoder)
        
        self.presenter = CollectionListPresenter(delegate: self)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Rijks Collection"
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == MainStoryboard.SegueIdentifiers.ShowArtDetail {
            let artDetailViewController = segue.destinationViewController as! ArtObjectDetailViewController
            artDetailViewController.objectId = artObjectID
        }
    }
}


extension CollectionListViewController {

    // MARK: - UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let collection = artObjects else { return  0}
        
        return collection.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MainStoryboard.CellIndetifiers.CollectionListCell, forIndexPath: indexPath) as! CollectionListCell
        
        guard let objects = artObjects else { return  cell}
        let object = objects[indexPath.row]
        
        if let image = object.headerImage, let imageURL = NSURL(string: image.url!){
            cell.artObjectImage.kf_setImageWithURL(imageURL)
            cell.artObjectImage.kf_setImageWithURL(imageURL, placeholderImage: UIImage(named: "placeholderImage"))
        }
        
        cell.artistName.text = object.principalOrFirstMaker
        cell.artObjectTitle.text = object.title
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let objects = artObjects else { return }
        
        artObjectID = objects[indexPath.row].objectNumber
        self.performSegueWithIdentifier(MainStoryboard.SegueIdentifiers.ShowArtDetail, sender: self)
    }
}

extension CollectionListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout, insets = flowLayout.sectionInset
        let itemWidth = collectionView.frame.width - insets.left - insets.right, itemHeight = CGFloat(150)
        
        return CGSizeMake(itemWidth, itemHeight)
    }
}

extension CollectionListViewController: CollectionListPresenterDelegate {
    
    // MARK: - CollectionListPresenterDelegate
    
    func didUpdateCollectionList(collection: CollectionList) {
        artObjects = collection.artObjects
    }
}