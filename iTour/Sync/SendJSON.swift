import Foundation

func sendCafesToAPI(cafes: [Cafes]) {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    
    guard let bodyData = try? encoder.encode(cafes) else {
           print("❌ Failed to encode cafes array.")
           return
       }

    guard let url = URL(string: "https://piranya87.outsystemscloud.com/DBAPI/rest/UserCafe/setUserCafe") else {
        print("Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = bodyData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error sending request: \(error)")
            return
        }

        if let httpResponse = response as? HTTPURLResponse {
            print("Response status: \(httpResponse.statusCode)")
        }

        if let data = data,
           let responseString = String(data: data, encoding: .utf8) {
            print("Response: \(responseString)")
        }
    }

    task.resume()
}
