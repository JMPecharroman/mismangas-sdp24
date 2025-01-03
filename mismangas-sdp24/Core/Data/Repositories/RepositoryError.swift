//
//  RepositoryError.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import Foundation

enum RepositoryError: Error, LocalizedError {
    case entityNotFound
    case modelContainerNotSet
    case notInitialized
}
