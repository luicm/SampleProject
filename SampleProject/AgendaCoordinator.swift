//
//  AgendaCoordinator.swift
//  SampleProject
//
//  Created by Luisa Cruz Molina on 02/07/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation

import Alamofire
import Freddy
import SwiftTask

protocol AgendaCoordinatorDelegate {
    
    var agendaCoordinator: AgendaCoordinator! { get }
    
    func didReceiveAgenda(agenda: Agenda)
}


public class AgendaCoordinator {
    
    private var agendaDelegate: AgendaCoordinatorDelegate?
    
    init(delegate: AgendaCoordinatorDelegate) {
        agendaDelegate = delegate
    }
    
    public func fetchCollectionList(date: String) {
        task_agenda(date)
            .success { value -> Void in
                self.agendaDelegate?.didReceiveAgenda(value)
            }
            .failure { (error: NetworkError?, isCancelled: Bool) -> Void in
                print(error)
        }
    }
}


extension AgendaCoordinator {
    
    typealias AgendaTask = Task<Float, Agenda, NetworkError>
    
    func task_agenda(date: String) -> AgendaTask {
        
        return AgendaTask { progress, fulfill, reject, configure in
            
            let collectionURL = Constants.BaseURL.URL + Constants.SelectedLanguage.English + Constants.EndPoints.Agenda + date
            
            Alamofire.request(.GET, collectionURL, parameters: ["key": Constants.APIKey.Key, "format": "json"])
                .responseJSON { response in
                    guard let JSONData = response.data else {
                        return
                    }
                    
                    do {
                        let json = try JSON(data: JSONData)
                        let agenda = try Agenda(json: json)
                        fulfill(agenda)
                    } catch {
                        reject(NetworkError.NoResponse)
                        return
                    }
            }
        }
    }
}