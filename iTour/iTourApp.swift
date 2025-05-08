//
//  iTourApp.swift
//  iTour
//
//  Created by Nick Tkachenko on 14.11.2024.
//

import SwiftUI
import SwiftData


@main
struct iTourApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Cafes.self)
        }
    }
}
