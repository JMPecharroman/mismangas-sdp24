//
//  Author+AuthorDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/12/24.
//

import Foundation

extension AuthorDTO {
    var toAuthor: Author? {
        guard let id = UUID(uuidString: self.id) else { return nil }
        
        return Author(
            id: id,
            firstName: firstName,
            lastName: lastName,
            role: role
        )
    }
}
