//
//  SwiftUiListViewBasicsApp.swift
//  SwiftUiListViewBasics
//
//  Created by THE BANYAN INFOTECH on 17/10/24.
//

import SwiftUI

@main
struct SwiftUiListViewBasicsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
           // WelcomeView()
            LandMarkList()
        }
    }
}
