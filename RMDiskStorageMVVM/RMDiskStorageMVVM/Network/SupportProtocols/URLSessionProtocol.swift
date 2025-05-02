//
//  URLSessionProtocol.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 02.05.2025.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask)
    }
}
