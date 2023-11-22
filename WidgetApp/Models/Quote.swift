//
//  Quote.swift
//  WidgetApp
//
//  Created by Esteban SEMELLIER on 22/11/2023.
//

import Foundation

protocol QuoteProtocol {
    var quote: String { get }
    var author: String { get }
}

struct Quote: Codable {
    var quote: String
    var author: String
}
