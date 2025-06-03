import SwiftUI
import SwiftData

struct ModifiedCafesListView: View {
    // Filter cafes where isModified == true
    @Query(filter: #Predicate<Cafes> { $0.isModified == true }) 
    var modifiedCafes: [Cafes]

    var body: some View {
        NavigationView {
            List(modifiedCafes) { cafe in
                VStack(alignment: .leading) {
                    Text(cafe.cafe)
                        .font(.headline)
                    Text("\(cafe.city), \(cafe.district)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if cafe.visitDate > Cafes.nullDate {
                        Text("Visited: \(cafe.visitDate.formatted(date: .long, time: .omitted))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Modified Cafés")
        }
    }
}
