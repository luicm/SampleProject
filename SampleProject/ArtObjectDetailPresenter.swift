//
//  ArtObjectDetailPresenter.swift
//  SampleProject
//
//  Created by Luisa Qardio on 01/07/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation

protocol ArtObjectDetailPresenterDelegate {
    
    var presenter: ArtObjectDetailPresenter! { get }
    
    func didUpdateArtObjectDetail(object: ArtObjectDetail)
}

final class ArtObjectDetailPresenter: ArtObjectDetailCoordinatorDelegate {
    
    var artObjectCoordinator: ArtObjectDetailCoordinator!
    
    private var delegate: ArtObjectDetailPresenterDelegate!
    
    var objectDetail: ArtObjectDetail? {
        didSet {
            delegate?.didUpdateArtObjectDetail(objectDetail!)
        }
    }
    
    init(delegate: ArtObjectDetailPresenterDelegate, objectId: String) {
        self.delegate = delegate
        artObjectCoordinator = ArtObjectDetailCoordinator(delegate: self)
        artObjectCoordinator.fetchCollectionList(objectId)
    }
    
    //MARK:- ArtObjectDetailCoordinatorDelegate
    
    func didReceiveArtObject(object: ArtObjectDetail) {
        objectDetail = object
    }
}