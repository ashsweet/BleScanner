//
//  BLEScannerManager.swift
//  RBCCompanion
//
//  Created by Aishwarya Mukherjee on 22/12/19.
//  Copyright © 2019 Aishwarya Mukherjee. All rights reserved.
//

import UIKit
import CoreBluetooth

class BLEScannerManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager!
    weak var checkInScannerView: CheckInScannerViewController?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }

    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
//        debugPrint("\nName   : \(peripheral.name ?? "(No name)")")
//        debugPrint("RSSI   : \(RSSI)")

        if let name = peripheral.name {
            if name.contains(GlobalConstants.HMIDeskString) && RSSI.intValue >= -70 {
                debugPrint("data found")
//                for ad in advertisementData {
//                    print("AD Data: \(ad)")
//                }
                central.stopScan()
                
            }
        }
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            debugPrint("Bluetooth is On")
            self.centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: NSNumber(value: true)])
        } else {
            debugPrint("Bluetooth is not active")
        }
    }

    func stopScan() {
        centralManager.stopScan()
    }
}
