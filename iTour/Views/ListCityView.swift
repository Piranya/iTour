import SwiftData
import SwiftUI

struct ListCityView: View {
    @Query var cafes: [Cafes]
    var selectedCountry: String
    var countriesDictionary: [String: [Cafes]] {
        Dictionary(grouping: cafes, by: { $0.country })
    }
 
 
    var body: some View {
            let citiesInCountry = countriesDictionary[selectedCountry] ?? []
            let uniqueCities = Array(Set(citiesInCountry.map { $0.city })).sorted()
            
            ForEach(uniqueCities, id: \.self) { city in
                NavigationLink(destination: ListDistrictView(selectedCity: city)) {
                    Text(city)
                }
            }
    }
 
}

#Preview {
    ListCityView(selectedCountry: "Portugal")
        .modelContainer(for: Cafes.self)
}
