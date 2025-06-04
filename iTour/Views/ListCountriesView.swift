import SwiftUI
import SwiftData

struct ListCountriesView: View {
    @Query var cafes: [Cafes]
    @State private var isExpanded: [String: Bool] = [:]

    // Group cafes by country
    var countries: [String] {
        Array(Set(cafes.map { $0.country })).sorted()
    }

    func cities(for country: String) -> [String] {
        let cafesInCountry = cafes.filter { $0.country == country }
        return Array(Set(cafesInCountry.map { $0.city })).sorted()
    }

    func cafeCount(for country: String) -> Int {
        cafes.filter { $0.country == country }.count
    }

    var body: some View {
        
            List {
                ForEach(countries, id: \.self) { country in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { isExpanded[country] ?? true },
                            set: { isExpanded[country] = $0 }
                        ),
                        content: {
                                ListCityView(selectedCountry: country)
                        },
                        label: {
                            HStack {
                                Text("\(country)") 
                                    .font(.headline)
                                
                            }
                        }
                    )
                    

                }
        }
    }
}

#Preview {
    ListCountriesView()
        .modelContainer(for: Cafes.self)
}
