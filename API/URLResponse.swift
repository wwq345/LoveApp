//
//  URLResponse.swift
//  wang.dov
//
//  Created by i564206 on 2022/3/9.
//

import Foundation

extension URLResponse{
    func toHttpUrlResponse() -> HTTPURLResponse? {
        guard let response = self as? HTTPURLResponse else{ return nil}
        return response
    }
}
