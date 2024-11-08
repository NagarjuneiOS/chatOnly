//
//  Untitled.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 07/11/24.
//
import Foundation
import UIKit
import SwiftUI
import Firebase
import FirebaseCore
import FirebaseMessaging
import FirebaseDatabase

class AppDelegate: UIResponder,UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
    
        return true
    }
    
    
}
