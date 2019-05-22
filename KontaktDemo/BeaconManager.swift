//
//  BeaconManager.swift
//  KontaktDemo
//
//  Created by Agam Gujral on 25/10/18.
//  Copyright © 2018 Agam Gujral. All rights reserved.
//

import UIKit
import KontaktSDK
class BeaconManager: NSObject {
    static let shared = BeaconManager()
    
    var beaconManager : KTKBeaconManager!
    var deviceManager : KTKDevicesManager!
    
    override init() {
        super.init()
        beaconManager = KTKBeaconManager(delegate: self)
        deviceManager = KTKDevicesManager(delegate: self)
    }
    //MARK:- Check Location Authorization
    func setupBeacons() {
        switch KTKBeaconManager.locationAuthorizationStatus() {
        case .notDetermined:
            beaconManager.requestLocationAlwaysAuthorization()
        case .denied, .restricted:
            print("<<<<<<Location Access restricted>>>>>>>")
        default:
            print("<<<<<<Location Access allowed>>>>>>>")
        }
    }
    func startDiscoveringBeacons() {
            switch KTKBeaconManager.locationAuthorizationStatus() {
            case.authorizedAlways:
                self.deviceManager.startDevicesDiscovery(withInterval: 2)//It will detect beacons after every 2 seconds.
            default:
                break
            }
    }
    func stopDiscoveringBeacons(){
        print("<<<<<<<<stopDiscoveringBeacons>>>>>>>>")
        self.deviceManager.stopDevicesDiscovery()
    }
    
    func restartDiscoveringBeacons() {
        switch KTKBeaconManager.locationAuthorizationStatus() {
        case.authorizedAlways:
            self.deviceManager.restartDeviceDiscovery { (error) in
                print(error ?? "Some error while restarting discovery")
            }
        default:
            break
        }
    }
    
}

extension BeaconManager : KTKBeaconManagerDelegate {
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.startDiscoveringBeacons()//Start Discovering beacons even in background state.
            print("<<<<<<Location Access allowed>>>>>>>")
        default:
            print("<<<<<<Location Access restricted>>>>>>>")
        }
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
        
        // Decide what to do when a user enters a range of your region; usually used
        // for triggering a local notification and/or starting a beacon ranging
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        // Decide what to do when a user exits a range of your region; usually used
        // for triggering a local notification and stoping a beacon ranging
    }
}
extension BeaconManager : KTKDevicesManagerDelegate {
    //MARK:- Devices Discovery Method
    //Detects Beacons in background state as well
    func devicesManager(_ manager: KTKDevicesManager, didDiscover devices: [KTKNearbyDevice]) {
        let nearbyBeacons = devices.sorted{UInt(truncating: $1.rssi) < UInt(truncating: $0.rssi)}
        for nearbyBeacon in nearbyBeacons {
            print(nearbyBeacon)
        }
    }
}
