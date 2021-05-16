//
//  String.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/5/21.
//

import Foundation

extension String {
    func hasMinimumNumberOfLetters(_ count: Int) -> Bool {
        return self.components(separatedBy: CharacterSet.letters.inverted).count >= count
    } // hasNumberOfLetters
    
    var withoutWhitespaces: String {
        let words = self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        let trimmedString = words.joined()
        return trimmedString
    } // withoutWhitespacesr
    
    var isOnlyNumbers: Bool {
        let trimmedString = self.withoutWhitespaces

        let alphaNumericRegex = ".*[^0-9].*"
        let alphaNumericTest = NSPredicate(format: "SELF MATCHES %@", alphaNumericRegex)
        return alphaNumericTest.evaluate(with: trimmedString)
    } // hasArabicCharacters
}
