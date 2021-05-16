//
//  ReusingIdentifier.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/4/21.
//

import Foundation

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
