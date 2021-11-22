//
//  ArticleExtended.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 18/11/2021.
//

import Foundation

struct ArticleExtended: Codable, Hashable {
    var id: Int
    var title: String
    var subtitle: String
    var date: String
    var body: String
}
