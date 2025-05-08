//
//  ListingElementView.swift
//  iTour
//
//  Created by Nick Tkachenko on 17.11.2024.
//
import SwiftData
import SwiftUI

struct ListCityView: View {
//   @Bindable var task: Task
    @Environment(\.modelContext) var modelContext
//    @Query(sort:[SortDescriptor(\Task.TaskCategoryOrder, order: .reverse),SortDescriptor(\Task.name, order: .forward)] ) var tasks: [Task]
    
    var city: String = "Gotham"
    let cafes: [Cafes] // Array passed to this view
   
    @State private var isExpanded: [String: Bool] = [:]
    
    var groupedTasks: [String: [Cafes]] {
        Dictionary(grouping: cafes, by: { $0.district })
    }
    
    var body: some View {
        
        List {
                       // Iterate over sorted dictionary keys
                       ForEach(groupedTasks.keys.sorted(), id: \.self) { category in
                           DisclosureGroup(
                               isExpanded: Binding(
                                   get: { isExpanded[category] ?? true },
                                   set: { isExpanded[category] = $0 }
                               ),
                               content: {
                                   // List of tasks in each category
                                   ForEach(groupedTasks[category] ?? []) { cafe in
//                                       Text(task.name)
                                       HStack {
                                           Toggle(cafe.cafe, isOn:  Binding(
                                            get: { cafe.isVisited },
                                            set: { cafe.isVisited = $0 }
                                        )).toggleStyle(SymbolToggleStyle())
                                       }
                                       
                                   }
                               },
                               label: {
                                   // Category title
                                   HStack {
                                       Text("\(category)") // Display Category
                                           .font(.headline)
                                       Spacer()
                                       Text("\(groupedTasks[category]?.count ?? 0) cafes") // Display count of items
                                           .foregroundColor(.gray)
                                   }
                               }
                           )
                       }
                   }
                   .navigationTitle(city)
               
    
}

struct SymbolToggleStyle: ToggleStyle {
    var onSymbol: String = "checkmark.circle.fill"
    var offSymbol: String = "circle"

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? onSymbol : offSymbol)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .green : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding()
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Task.self, configurations: config)
//        let example = Task(id: 1, name: "Concrete Test - Slab", lotNumber: "0065", planName: "Samoa", comunityName: "Lotus Palm", categoryName: "Shell", details: "", lotReleaseDate:.now, categoryLastUpdated: .now, completionDate: .now, TaskCategoryOrder: 1, modifiedAt: nil)
//
//        return ListTasksView(task: example)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//    
//    ListLotsView(sort: SortDescriptor(\Task.name), searchString: "")
//
}
