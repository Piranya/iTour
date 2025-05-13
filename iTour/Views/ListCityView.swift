import SwiftData
import SwiftUI

struct ListCityView: View {
//    @Environment(\.modelContext) var modelContext
    @Query var cafes: [Cafes]

    var selectedCountry: String
    var countriesDictionary: [String: [Cafes]] {
        Dictionary(grouping: cafes, by: { $0.country })
    }
 
 
    var body: some View {
        NavigationView {
            let citiesInCountry = countriesDictionary[selectedCountry] ?? []
            let uniqueCities = Array(Set(citiesInCountry.map { $0.city })).sorted()
            
            //        List {
            ForEach(uniqueCities, id: \.self) { city in
                //                Text(city)
                NavigationLink(destination: ListDistrictView(selectedCity: city)) {
                    Text(city)
                }
                
            }
            //        }
            .navigationTitle(selectedCountry)
            
            
        }
    }
 
}//view

#Preview {
    ListCityView(selectedCountry: "Portugal")
        .modelContainer(for: Cafes.self)
}
