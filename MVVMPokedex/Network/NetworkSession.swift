//
//  NetworkSession.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 31/01/22.
//

import Foundation

protocol NetworkSession {

    func executeRequest(with url: URL,
                        completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void))
}
