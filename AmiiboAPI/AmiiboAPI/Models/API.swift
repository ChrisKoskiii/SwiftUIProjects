//
//  API.swift
//  AmiiboAPI
//
//  Created by Christopher Koski on 3/24/22.
//

import Foundation

class apiCall {
    func getAmiibos(completion:@escaping (Amiibos) -> ()) {
        guard let url = URL(string: "https://www.amiiboapi.com/api/amiibo/") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let amiibos = try! JSONDecoder().decode(Amiibos.self, from: data!)
            print(amiibos)
            
            DispatchQueue.main.async {
                completion(amiibos)
            }
        }
        .resume()
    }
}
