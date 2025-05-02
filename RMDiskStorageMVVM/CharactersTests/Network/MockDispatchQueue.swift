//
//  MockDispatchQueue.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 02.05.2025.
//

import Foundation
@testable import RMDiskStorageMVVM

final class MockDispatchQueue: DispatchQueueProtocol {
    func async(_ block: @escaping () -> Void) {
        block()
    }
}
