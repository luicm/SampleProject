//
//  AgendaPresenter.swift
//  SampleProject
//
//  Created by Luisa Cruz Molina on 02/07/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation

protocol AgendaPresenterDelegate {
    
    var presenter: AgendaPresenter! { get }
    
    func didUpdateAgenda(agenda: Agenda)
}

final class AgendaPresenter: AgendaCoordinatorDelegate {
    
    var agendaCoordinator: AgendaCoordinator!
    
    private var delegate: AgendaPresenterDelegate!
    
    var agenda: Agenda? {
        didSet {
            delegate?.didUpdateAgenda(agenda!)
        }
    }
    
    init(delegate: AgendaPresenterDelegate, date: String) {
        self.delegate = delegate
        agendaCoordinator = AgendaCoordinator(delegate: self)
        updateAgenda(date: date)
    }
    
    func updateAgenda(date date:String) {
        agendaCoordinator.fetchCollectionList(date)
    }
    
    //MARK:- AgendaCoordinatorDelegate
    
    func didReceiveAgenda(agenda: Agenda) {
        self.agenda = agenda
    }
}