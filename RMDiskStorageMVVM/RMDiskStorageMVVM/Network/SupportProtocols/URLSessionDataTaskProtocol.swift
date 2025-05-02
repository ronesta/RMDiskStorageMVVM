//
//  URLSessionDataTaskProtocol.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 02.05.2025.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
