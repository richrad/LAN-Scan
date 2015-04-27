//
//  InterfaceController.swift
//  LAN Scan WatchKit Extension
//
//  Created by Richard Allen on 4/27/15.
//  Copyright (c) 2015 Smart Touch. All rights reserved.
//

import WatchKit
import Foundation
import LANScanKit

class InterfaceController: WKInterfaceController, ScanLANDelegate {
    
    @IBOutlet weak var table: WKInterfaceTable!
    var devices = [Device]()
    
    var scanner: ScanLAN?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        scanner = ScanLAN(delegate: self)
        scanner?.startScan()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadTable() {
        table.setNumberOfRows(devices.count, withRowType: "DeviceRow")
        for (index: Int, device: Device) in enumerate(devices) {
            if let row = table.rowControllerAtIndex(index) as? DeviceRow {
                row.deviceNameLabel.setText(device.name)
                row.deviceIPLabel.setText(device.address)
            }
        }
    }
    
    func scanLANDidFindNewAddress(address: String!, havingHostName hostName: String!) {
        let device = Device()
        device.address = address
        device.name = hostName
        devices.append(device)
        loadTable()
    }
    
    func scanLANDidFinishScanning() {
        
    }
    
    @IBAction func refresh() {
        scanner?.stopScan()
        devices = [Device]()
        table.setNumberOfRows(0, withRowType: "DeviceRow")
        scanner?.startScan()
    }

}
