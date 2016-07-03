//
//  CollectionListCoordinator.swift
//  SampleProject
//
//  Created by Luisa Qardio on 30/06/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation
import Alamofire
import Freddy
import SwiftTask

protocol CollectionListCoordinatorDelegate {
    
    var collectionCoordinator: CollectionListCoordinator! { get }
    
    func didReceiveCollectionList(collection: CollectionList)
}


public class CollectionListCoordinator {
    
    private var collectionDelegate: CollectionListCoordinatorDelegate?
    
    init(delegate: CollectionListCoordinatorDelegate) {
        collectionDelegate = delegate
    }
    
    public func fetchCollectionList() {
        task_conllectionList()
            .success { value -> Void in
                self.collectionDelegate?.didReceiveCollectionList(value)
            }
            .failure { (error: NetworkError?, isCancelled: Bool) -> Void in
                print(error)
        }
    }
}


extension CollectionListCoordinator {
    
    typealias CollectionListTask = Task<Float, CollectionList, NetworkError>
    
    func task_conllectionList() -> CollectionListTask {
        return CollectionListTask { progress, fulfill, reject, configure in
            let collectionURL = Constants.BaseURL.URL + Constants.SelectedLanguage.English + Constants.EndPoints.Collection
            Alamofire.request(.GET, collectionURL, parameters: ["key": Constants.APIKey.Key, "format": "json"])
                .responseJSON { response in
                    guard let JSONData = response.data else {
                        return
                    }
                    
                    do {
                        let json = try JSON(data: JSONData)
                        let conllectionList = try CollectionList(json: json)
                        fulfill(conllectionList)
                    } catch {
                        reject(NetworkError.NoResponse)
                        return
                    }
            }
        }
    }
}