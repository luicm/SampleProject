//
//  AgendaViewController.swift
//  SampleProject
//
//  Created by Luisa Cruz Molina on 02/07/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import UIKit
import SafariServices


class AgendaViewController: UITableViewController {
    
    var presenter: AgendaPresenter!
    
    private var datePickerViewOpen = false
    private var agenda: [Event]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var dateSelected = NSDate()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Agenda"
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone(name: "GMT")
        let date = formatter.stringFromDate(NSDate())
        
        presenter = AgendaPresenter(delegate: self, date: date)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
}

extension AgendaViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let events = agenda else { return 0 }
        
        return events.count == 0 ? 3 : events.count + 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIndetifiers.AgendaDateSelectedCell, forIndexPath: indexPath) as! AgendaDateSelectedCell
            cell.setDate(dateSelected)
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIndetifiers.AgendaDatePickerCell, forIndexPath: indexPath) as! AgendaDatePickerCell
            cell.delegate = self
            return cell
        } else {
            if agenda!.count == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIndetifiers.AgendaNoEventCell, forIndexPath: indexPath)
                return cell
            }
            
            let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIndetifiers.AgendaEventCell, forIndexPath: indexPath) as! EventCell
            cell.delegate = self
            let event = agenda![indexPath.row-2]
            cell.setUpCell(event: event)
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 1 && !datePickerViewOpen {
            return 0
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.beginUpdates()
        
        if indexPath.row == 0 {
            datePickerViewOpen = !datePickerViewOpen
        }
        tableView.endUpdates()
    }
}


extension AgendaViewController: AgendaPresenterDelegate, AgendaDatePickerCellDelegate, EventCellDelegate, SFSafariViewControllerDelegate {
    
    // MARK: - AgendaPresenterDelegate
    
    func didUpdateAgenda(agenda: Agenda) {
        self.agenda = agenda.events
    }
    
    // MARK: - AgendaDatePickerCellDelegate
    
    func agendaDatePickerViewDidChangeValue(date: NSDate) {
        
        dateSelected = date
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone(name: "GMT")
        let newDate = formatter.stringFromDate(date)
        presenter.updateAgenda(date: newDate)
        datePickerViewOpen = false
    }
    
    // MARK: - EventCellDelegate
    
    func didTapLearnMoreButton(url: String) {
        
        let safariViewController = SFSafariViewController(URL: NSURL(string: url)!)
        safariViewController.delegate = self
        self.presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    func didTapGetTicketsButton(url: String) {
        
        let safariViewController = SFSafariViewController(URL: NSURL(string: url)!)
        safariViewController.delegate = self
        self.presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    // MARK: - SFSafariViewControllerDelegate
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}