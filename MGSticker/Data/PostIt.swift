//
//  PostIt.swift
//  MGSticker
//
//  Created by Michel Garlandat on 09/10/2020.
//

import Foundation

struct PostIt: Codable {
    let text: String
    let fgColorString: String
    let bgColorString: String
    let fontSize: Int
    let selected: Bool
}
