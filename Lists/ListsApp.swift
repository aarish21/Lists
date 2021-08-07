//
//  ListsApp.swift
//  Lists
//
//  Created by Aarish Rahman on 07/08/21.
//

import SwiftUI

@main
struct ListsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
