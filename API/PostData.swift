//
//  PostData.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/22.
//

import Foundation


struct Post: Identifiable, Codable{
    var id: Int = 0
    var title: String
    var body: String
}

class Api{
    func getPosts(completion: @escaping ([Post]) -> ()){
        //guard let url = URL(string: "htp://192.168.0.0.1/users/getuser")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _)  in
            guard let data = data else {
                return
            }

            let posts = try! JSONDecoder().decode([Post].self, from: data)
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}
