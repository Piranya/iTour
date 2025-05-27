import SwiftUI
import SwiftData

struct ListDistrictView: View {
    @Environment(\.modelContext) var modelContext
    @Query var cafes: [Cafes]
    @State private var isExpanded: [String: Bool] = [:]
    @State private var showingSheet: Bool = false
    @State private var selectedCafe: Cafes? = nil
    @State private var showSheet = false
    
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
                                Toggle(isOn:  Binding(
                                 get: { cafe.isVisited },
                                 set: { cafe.isVisited = $0 }
                                )){
                                    Text(cafe.cafe)
                                        .onTapGesture {
                                            selectedCafe = cafe
                                            showSheet = true
                                        }
                                }
                                .toggleStyle(SymbolToggleStyle())
                            }
                        }
                    },
                    label: {
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
        .navigationTitle("\(selectedCity) districts")
        .sheet(isPresented: $showSheet) {
            if let cafe = selectedCafe {
                CafeDetailSheet(cafe: cafe)
                    .presentationDetents([.medium, .large])
                    .presentationBackgroundInteraction(.automatic)
                    .presentationBackground(.regularMaterial)
                    .presentationDragIndicator(.visible)
            }
        }
    }
    

}

struct CafeDetailSheet: View {
    let cafe: Cafes
    @State private var selectedOverall = "Fire"
    @State private var selectedPrice = "Steal"
    @State private var selectedContact = ""
    
    let ratings = loadRatingsFromFile()

    var body: some View {
        List{
            VStack(spacing: 10) {
                Spacer()
                Text("\(cafe.cafe)")
                    .font(.title)
                Spacer()
                DatePicker(selection: .constant(Date()), label: { Text("Visit Date") })
                //TODO: bind to cafe.visitdate
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Overall Rating")
                            .font(.headline)
                        Picker("Overall", selection: $selectedOverall) {
                            ForEach(ratings?.overall ?? [], id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    VStack {
                        Text("Price Rating")
                            .font(.headline)
                        Picker("Price", selection: $selectedPrice) {
                            ForEach(ratings?.price ?? [], id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    VStack {
                        Text("Contact Person")
                            .font(.headline)
                        Picker("Contact", selection: $selectedContact) {
                            ForEach(ratings?.contact ?? [], id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(.automatic)
                    }
                    Spacer()
                    
                }
                .padding()
            }
        }
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
                .frame(width: 20, height: 20)
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
