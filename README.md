# KontaktDemo
Easy for you to configure, monitor, and securely update Kontakt.io Beacons.

# Kontakt Administration App
To configure Kontakt.io Devices please download Kontakt iOS Administration App from Appstore.

# CocoaPods
To integrate the Kontakt.io iOS/tvOS/macOS SDK into your Xcode project using CocoaPods, specify it in your Podfile:

        platform :ios, '8.0'
        target 'APP_NAME' do
        # if swift
        use_frameworks!

        pod 'KontaktSDK'
        end

- Initialize Kontakt

        import UIKit
        import KontaktSDK
        @UIApplicationMain
        class AppDelegate: UIResponder, UIApplicationDelegate {

        var window: UIWindow?


        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
           // Override point for customization after application launch.
           //MARK:- Setting Up Order ID
           Kontakt.setAPIKey("")//Enter Order ID of Kontakt to import all beacons.
           BeaconManager.shared.setupBeacons()
           return true
        }
