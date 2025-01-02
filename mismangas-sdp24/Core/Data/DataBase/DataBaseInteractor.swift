//
//  DataBaseInteractor.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import SwiftData

@RepositoryActor
protocol DataBaseInteractor {
    var context: ModelContext { get }
}
