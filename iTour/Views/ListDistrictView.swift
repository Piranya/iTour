import SwiftUI
import SwiftData

struct ListDistrictView: View {
    @Environment(\.modelContext) var modelContext
    @Query var cafes: [Cafes]
    @State private var isExpanded: [String: Bool] = [:]

    var selectedCity: String
//    @State private var isExpanded: [String: Bool] = [:]

    var cafesInCity: [Cafes] {
        cafes.filter { $0.city == selectedCity }
    }

    var groupedByDistrict: [String: [Cafes]] {
        Dictionary(grouping: cafesInCity, by: { $0.district })
    }

    
    var body: some View {
     
        let districtNames = Array(Set(cafesInCity.map {$0.district})).sorted (by: <)


        List {
            ForEach(districtNames, id: \.self) { district in
                
                DisclosureGroup(
                    isExpanded: Binding(
                        get: { isExpanded[district] ?? true },
                        set: { isExpanded[district] = $0 }
                    ),
                    content: {
                        ForEach(groupedByDistrict[district] ?? []) { cafe in
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
                            Text("\(district)") // Display Category
                                .font(.headline)
                            Spacer()
                            Text("\(groupedByDistrict[district]?.count ?? 0) cafes")
                                .foregroundColor(.gray)
                        }
                    }
                )
                

            }
        }
        .navigationTitle(selectedCity)
    }
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


#Preview {
    ListDistrictView(selectedCity: "Lisbon")
        .modelContainer(for: Cafes.self)
}
