 //
//  DEstinationListingView.swift
//  iTour
//
//  Created by Nick Tkachenko on 15.11.2024.
//

import SwiftUI
import SwiftData

struct ListCountriesView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort:[SortDescriptor(\Cafes.country, order: .reverse),SortDescriptor(\Cafes.city, order: .forward)] ) var cafes: [Cafes]
    
    var body: some View {
        let lotsDictionary = Dictionary(grouping: cafes, by: { $0.country })
//
//        print("lotsDictionary: \(lotsDictionary)")
        
        List {
                        // Iterate through dictionary values
                        ForEach(Array(lotsDictionary.keys), id: \.self) { key in
                            if let values = lotsDictionary[key] {
                                NavigationLink(destination: ListCityView(city: key, cafes: values)) {
                                    HStack {
                                        Text("\(key)") // Display the key
                                            .font(.headline)
                                        Spacer()
                                        Text("\(values.count) cafes") // Display count of items
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
            .onAppear
            {
                for destination in cafes {
                    if destination.cafe == ""
                    {
                        modelContext.delete(destination)
                    }
                }
            }
        } //list
        

    


    
    init(sort: SortDescriptor<Cafes>, searchString: String){
        _cafes = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.city.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = cafes[index]
            modelContext.delete(destination)
        }
    }
} //view

#Preview {
    ListCountriesView(sort: SortDescriptor(\Cafes.city), searchString: "")
}
