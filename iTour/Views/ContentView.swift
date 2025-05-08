//
//  ContentView.swift
//  iTour
//
//  Created by Nick Tkachenko on 14.11.2024.
//

import SwiftData
import SwiftUI
import Foundation

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
  //  @Query(sort: \Task.lotNumber ) var destinations: [Destination]
//    @Query(sort:[SortDescriptor(\Task.lotNumber, order: .reverse),SortDescriptor(\Task.TaskCategoryOrder, order: .forward),SortDescriptor(\Task.name, order: .forward)] ) var tasks: [Task]

    @State private var path = [Cafes]()
    @State private var sortOrder = SortDescriptor(\Cafes.city)
    @State private var searchText = ""
    
    var body: some View {
        
        
        NavigationStack(path: $path){
            ListCountriesView(sort: sortOrder, searchString: searchText)
            .navigationTitle("Cafes")
//                .navigationDestination(for: Cafes.self, destination: EditDestinationView.init)
                .searchable(text: $searchText)
                .toolbar{
                    Button("Add Samples", action: addSamples)
                    Button("Clear Data", action: clearSamples)
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort", selection: $sortOrder){
                        Text("City")
                            .tag(SortDescriptor(\Cafes.city))
                        
//                        Text("Date")
//                                .tag(SortDescriptor(\Cafes.))
                    }
                    .pickerStyle(.inline)
                    }
                }
           
        }
    }
    
    func clearSamples() {
        do {
            let fetchDescriptor = FetchDescriptor<Cafes>()
            let allCafes = try modelContext.fetch(fetchDescriptor)

            for cafe in allCafes {
                modelContext.delete(cafe)
            }

            try modelContext.save()
        } catch {
            print("Failed to delete all cafes: \(error)")
        }
    }
    
    func addSamples() {
        ModelData().cafes.forEach {
            modelContext.insert($0)
        }

    }
    

  


}

#Preview {
    ContentView()
}
