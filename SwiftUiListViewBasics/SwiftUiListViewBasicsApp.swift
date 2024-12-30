//
//  SwiftUiListViewBasicsApp.swift
//  SwiftUiListViewBasics
//
//  Created by Nagarjune on 17/10/24.
//

import SwiftUI

@main
struct SwiftUiListViewBasicsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let loginKey = UserDefaults.standard.value(forKey: "loggedin")

    
    var body: some Scene {
        WindowGroup {
            if (self.loginKey as? String ?? "") == "true"{
                LandMarkList()
            }else{
                
                NewWelcomeView()
            }
            
         
            
           
        }
    }
}
