import SwiftUI
import SwiftData

struct ModifiedCafesListView: View {
    // Filter cafes where isModified == true
    @Query(filter: #Predicate<Cafes> { $0.isModified == true }) 
    var modifiedCafes: [Cafes]

    var body: some View {
        NavigationStack {
            List(modifiedCafes) { cafe in
                VStack(alignment: .leading) {
                    Text(cafe.cafe)
                        .font(.headline)
                    Text("\(cafe.city), \(cafe.district)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Rate: \(cafe.rateOverall ), Price: \(cafe.ratePrice)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Contact: \(cafe.selectedContact )")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    if cafe.visitDate > Cafes.nullDate {
                        Text("Visited: \(cafe.visitDate.formatted(date: .long, time: .omitted))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                        Text("Modified: \(cafe.lastModified.formatted(date: .long, time: .omitted))")
                            .font(.caption)
                            .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        cafe.isModified = false
                        cafe.isVisited = false
                        cafe.visitDate = Cafes.nullDate
                        cafe.rateOverall = ""
                        cafe.ratePrice = ""
                        cafe.selectedContact = ""
                    } label: {
                        Label("Reset", systemImage: "xmark.circle.fill")
                    }
                    Button(role: .cancel) {
                        cafe.update(keyPath: \.isVisited, to: false)
                        cafe.update(keyPath: \.visitDate, to: Cafes.nullDate)
                     } label: {
                         Label("isVisited", systemImage: "xmark.circle")
                     }
                     .tint(.orange)
                    Button(role: .destructive) {
                        cafe.update(keyPath: \.isModified, to: false)
                    } label: {
                        Label("isModified", systemImage: "xmark.circle")
                    }
                     .tint(.orange)
                 }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        //sync individual item
                    } label: {
                        Label("Sync", systemImage: "xmark.circle.fill")
                            .tint(.green)
                    }
                    
                 }
            }
            .navigationTitle("Modified Cafés")

            .toolbar{
                Menu("Sync Actions") {
                    Button("Send data to Server", action: {})
                    Button("Get data from Server", action: {})
                    Menu("Reset") {
                        Button("Reset all local changes", action: {})
                        Button("Reset isVisited attribute", action: {})
                        Button("Reset isModified attibute", action: {})
                    }
                    
                }
            }
            
        }
    }
}
#Preview {
    ModifiedCafesListView()
        .modelContainer(for: Cafes.self)
}

