/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A representation of a hike.
*/

import Foundation

struct Rate: Codable, Hashable, Identifiable {
    var id: Int
    var observations: [Observation]

    struct Observation: Codable, Hashable {
        var overall: String
        var price: String
    }
}
