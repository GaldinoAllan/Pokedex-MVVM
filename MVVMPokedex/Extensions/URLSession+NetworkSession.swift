//
//  URLSession+NetworkSession.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 31/01/22.
//

import Foundation

extension URLSession: NetworkSession {

    func executeRequest(with url: URL,
                        completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        let task = dataTask(with: url) { data, urlResponse, error in
            completionHandler(data, urlResponse, error)
        }
        task.resume()
    }
}
