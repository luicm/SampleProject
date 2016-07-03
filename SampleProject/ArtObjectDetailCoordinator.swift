//
//  ArtObjectDetailCoordinator.swift
//  SampleProject
//
//  Created by Luisa Qardio on 01/07/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation
import Alamofire
import Freddy
import SwiftTask

protocol ArtObjectDetailCoordinatorDelegate {
    
    var artObjectCoordinator: ArtObjectDetailCoordinator! { get }
    
    func didReceiveArtObject(object: ArtObjectDetail)
}

public class ArtObjectDetailCoordinator {
    
    private var artObjectDetailDelegate: ArtObjectDetailCoordinatorDelegate?
    
    init(delegate: ArtObjectDetailCoordinatorDelegate) {
        artObjectDetailDelegate = delegate
    }
    
    public func fetchCollectionList(objectID: String) {
        task_artObjectDetail(objectID)
            .success { value -> Void in
                self.artObjectDetailDelegate?.didReceiveArtObject(value)
            }
            .failure { (error: NetworkError?, isCancelled: Bool) -> Void in
                print(error)
        }
    }
}

extension ArtObjectDetailCoordinator {
    
    typealias ArtObjectDetailTask = Task<Float, ArtObjectDetail, NetworkError>
    
    func task_artObjectDetail(objectID: String) -> ArtObjectDetailTask {
        
        return ArtObjectDetailTask { progress, fulfill, reject, configure in
            
            let artObjectDetailURL = Constants.BaseURL.URL + Constants.SelectedLanguage.English + Constants.EndPoints.Collection + objectID
            
            Alamofire.request(.GET, artObjectDetailURL, parameters: ["key": Constants.APIKey.Key, "format": "json"])
                .responseJSON { response in
                    guard let JSONData = response.data else {
                        return
                    }
                    
                    do {
                        let json = try JSON(data: JSONData)
                        let artObjectDetail = try ArtObjectDetail(json: json)
                        fulfill(artObjectDetail)
                    } catch {
                        reject(NetworkError.NoResponse)
                        return
                    }
            }
        }
    }
}