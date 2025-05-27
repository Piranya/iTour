import Foundation

struct Ratings: Codable {
    let overall: [String]
    let price: [String]
    let contact: [String]
}

func loadRatingsFromFile() -> Ratings? {
    guard let url = Bundle.main.url(forResource: "ratesData", withExtension: "json") else {
        print("ratesData.json not found.")
        return nil
    }

    do {
        let data = try Data(contentsOf: url)
        let decoded = try JSONDecoder().decode(Ratings.self, from: data)
        return decoded
    } catch {
        print("Error loading or decoding file: \(error)")
        return nil
    }
}

