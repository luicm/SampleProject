//
//  CollectionListPresenter.swift
//  SampleProject
//
//  Created by Luisa Qardio on 30/06/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation

protocol CollectionListPresenterDelegate {
    
    var presenter: CollectionListPresenter! { get }
    
    func didUpdateCollectionList(collection: CollectionList)
}

final class CollectionListPresenter: CollectionListCoordinatorDelegate {
    
    var collectionCoordinator: CollectionListCoordinator!
    
    private var delegate: CollectionListPresenterDelegate!
    
    var collection: CollectionList? {
        didSet {
            delegate?.didUpdateCollectionList(collection!)
        }
    }
    
    init(delegate: CollectionListPresenterDelegate) {
        self.delegate = delegate
        collectionCoordinator = CollectionListCoordinator(delegate: self)
        collectionCoordinator.fetchCollectionList()
    }
    
    //MARK:- CollectionListCoordinatorDelegate
    
    func didReceiveCollectionList(collection: CollectionList) {
        self.collection = collection
    }
}