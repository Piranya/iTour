import Foundation
import SwiftData
import SwiftUI
@Model
class Cafes: Codable, Hashable {
    var id: Int = 0
    var country: String = ""
    var city: String = ""
    var district: String = ""
    var cafe: String = ""
    var visitDate: Date = nullDate
    var isVisited: Bool = false
    var isLoved: Bool = false
    var isModified: Bool = false
    var rateOverall: String = ""
    var ratePrice: String = ""
    var selectedContact: String = ""
    var lastModified: Date = nullDate
    
    
    init(id: Int, country: String = "", city: String = "", district: String = "", cafe: String = "",  visitDate: Date? = Cafes.nullDate, isVisited: Bool = false, isLoved: Bool = false, isModified: Bool = false, rateOverall: String = "", ratePrice: String = "", selectedContact: String = "", lastModified: Date? = Cafes.nullDate
    ) {
        self.id = id
        self.country = country
        self.city = city
        self.district = district
        self.cafe = cafe
        self.visitDate = visitDate ?? Cafes.nullDate
        self.isVisited = isVisited
        self.isLoved = isLoved
        self.isModified = isModified
        self.rateOverall = rateOverall
        self.ratePrice = ratePrice
        self.selectedContact = selectedContact
        self.lastModified = lastModified ?? Cafes.nullDate
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        let city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        let district = try container.decodeIfPresent(String.self, forKey: .district) ?? ""
        let cafe = try container.decodeIfPresent(String.self, forKey: .cafe) ?? ""
        let visitDate = try container.decodeIfPresent(Date.self, forKey: .visitDate) ?? Self.nullDate
        let isVisited = try container.decodeIfPresent(Bool.self, forKey: .isVisited) ?? false
        let isLoved = try container.decodeIfPresent(Bool.self, forKey: .isLoved) ?? false
        let isModified = try container.decodeIfPresent(Bool.self, forKey: .isModified) ?? false
        let rateOverall = try container.decodeIfPresent(String.self, forKey: .rateOverall) ?? ""
        let ratePrice = try container.decodeIfPresent(String.self, forKey: .ratePrice) ?? ""
        let selectedContact = try container.decodeIfPresent(String.self, forKey: .selectedContact) ?? ""
        let lastModified = try container.decodeIfPresent(Date.self, forKey: .lastModified) ?? Self.nullDate
        self.init(
            id: id,
            country: country,
            city: city,
            district: district,
            cafe: cafe,
            visitDate: visitDate,
            isVisited: isVisited,
            isLoved: isLoved,
            isModified: isModified,
            rateOverall: rateOverall,
            ratePrice: ratePrice,
            selectedContact: selectedContact,
            lastModified: lastModified
        )
    }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(id, forKey: .id)
            try container.encode(country, forKey: .country)
            try container.encode(city, forKey: .city)
            try container.encode(district, forKey: .district)
            try container.encode(cafe, forKey: .cafe)
            try container.encode(visitDate, forKey: .visitDate)
            try container.encode(isVisited, forKey: .isVisited)
            try container.encode(isLoved, forKey: .isLoved)
            try container.encode(isModified, forKey: .isModified)
            try container.encode(rateOverall, forKey: .rateOverall)
            try container.encode(ratePrice, forKey: .ratePrice)
            try container.encode(selectedContact, forKey: .selectedContact)
        }
    
    private enum CodingKeys: String, CodingKey {
        case id, country, city, district, cafe, visitDate, isVisited, isLoved, isModified, rateOverall, ratePrice, selectedContact, lastModified
    }
    
    static var nullDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: "1900-01-01") ?? Date.distantPast
    }
    
    func update<T>(keyPath: ReferenceWritableKeyPath<Cafes, T>, to value: T) {
         self[keyPath: keyPath] = value
         lastModified = .now
         isModified = true
     }
    
}
