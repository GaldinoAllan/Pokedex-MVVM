//
//  NetworkSessionMock.swift
//  MVVMPokedexTests
//
//  Created by Allan Gazola Galdino on 03/02/22.
//

import Foundation
@testable import MVVMPokedex

struct NetworkSessionMock: NetworkSession {
    
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    func executeRequest(with url: URL,
                        completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        completionHandler(data, urlResponse, error)
    }
}
