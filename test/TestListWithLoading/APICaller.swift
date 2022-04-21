//
//  APICaller.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/18.
//

import Foundation


class APICaller {
    var isPagination = false
    func fetchData(pagination: Bool = false,  completion: @escaping (Result<[String], Error>) -> Void) {
        if pagination {
            isPagination = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2 )) {
            let originalData = [
                "Apple",
                "Banana",
                "Circle",
                "Destination",
                "Equipment",
                "FaceBook",
                "juraka",
                "Happy",
                "Image",
                "glory",
                "Apple",
                "Banana",
                "Circle",
                "Destination",
                "Equipment",
                "FaceBook",
                "juraka",
                "Happy",
                "Image",
                "glory",
                "Apple",
                "Banana",
                "Circle",
                "Destination",
                "Equipment",
                "FaceBook",
                "juraka",
                "Happy",
                "Image",
                "glory"
            ]
            let newData = [
                "Ken",
                "Lemon",
                "Message",
                "No",
                "order",
                "proper"
            ]
            completion(.success(pagination ? newData : originalData))
            if pagination {
                self.isPagination = false
            }
        }
    }
}

