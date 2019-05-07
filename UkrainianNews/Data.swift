
import Foundation

class myData {
    static func getData(completion: @escaping ([News]) -> ()) {
        var finalData = [News]()
        DispatchQueue.global(qos: .background).async {
            let jsonUrlString = "https://newsapi.org/v2/top-headlines?country=ua&apiKey=0cff1368c1d1445d9a0bccb6063a5220"
            guard let url = URL(string: jsonUrlString) else { return }
            if let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                if let jsonPetitions = try? decoder.decode(Model.self, from: data) {
                    finalData = jsonPetitions.articles
                }
            }
            DispatchQueue.main.async {
                completion(finalData)
            }
        }
    }
}
