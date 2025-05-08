//
//  Destination.swift
//  iTour
//
//  Created by Nick Tkachenko on 14.11.2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Cafes: Decodable, Hashable {
    var id: Int
    var country: String
    var city: String
    var district: String
    var cafe: String
    var visitDate: Date
    var isVisited: Bool = false
    var isLoved: Bool = false
    var isModified: Bool = false

    
    init(id: Int, country: String = "", city: String = "", district: String = "", cafe: String = "",  visitDate: Date? = nil, isVisited: Bool = false,isLoved: Bool = false, isModified: Bool = false) {
        self.id = id
        self.country = country
        self.city = city
        self.district = district
        self.cafe = cafe
        self.visitDate = visitDate ?? Cafes.nullDate
        self.isVisited = isVisited
        self.isLoved = isLoved
        self.isModified = isModified
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        let city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        let district = try container.decodeIfPresent(String.self, forKey: .district) ?? ""
        let cafe = try container.decodeIfPresent(String.self, forKey: .cafe) ?? ""
        let visitDate = try container.decodeIfPresent(Date.self, forKey: .visitDate)
        let isVisited = try container.decodeIfPresent(Bool.self, forKey: .isVisited) ?? false
        let isLoved = try container.decodeIfPresent(Bool.self, forKey: .isLoved) ?? false
        let isModified = try container.decodeIfPresent(Bool.self, forKey: .isModified) ?? false

        self.init(
            id: id,
            country: country,
            city: city,
            district: district,
            cafe: cafe,
            visitDate: visitDate,
            isVisited: isVisited,
            isLoved: isLoved,
            isModified: isModified
        )
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, country, city, district, cafe, visitDate, isVisited, isLoved, isModified
    }
    
    static var nullDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: "1900-01-01") ?? Date.distantPast
    }
}
