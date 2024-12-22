//
//  Consulate.swift
//  VisaApp
//
//  Created by oihtiyar on 16.12.2024.
//

import Foundation

struct Consulate: Identifiable, Decodable {
    var id: String { name }  // Konsolosluk ismini kimlik olarak kullanabiliriz
    let name: String
    let date: String
}

