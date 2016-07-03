//
//  Constants.swift
//  SampleProject
//
//  Created by Luisa Qardio on 30/06/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation

struct Constants {
    
    struct BaseURL {
        static let URL = "https://www.rijksmuseum.nl/api/"
    }
    
    struct SelectedLanguage {
        static let English = "en/"
        static let Dutch = "nl/"
    }
    
    struct APIKey {
        static let Key = "gMyv5dhy"
    }
    
    struct EndPoints {
        static let Collection = "collection/"
        static let Agenda = "agenda/"
    }
}

struct MainStoryboard {
    
    struct SegueIdentifiers {
        static let ShowArtDetail = "ShowArtObjectDetail"
    }
    
    struct CellIndetifiers {
        static let CollectionListCell = "Cell"
        static let AgendaDateSelectedCell = "DateSelectedCell"
        static let AgendaDatePickerCell = "DatePickerCell"
        static let AgendaEventCell = "EventCell"
        static let AgendaNoEventCell = "NoEventsCell"
        
    }
}

public enum NetworkError: ErrorType {
    case NoResponse
    case NoData
}