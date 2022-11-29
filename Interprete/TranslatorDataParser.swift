//
//  TranslatorDataParser.swift
//  Interprete
//
//  Created by Максим Митрофанов on 24.05.2022.
//

import Foundation
import SwiftSoup

class TranslatorDataParser: ObservableObject {
    @Published var wordTranslation: String = ""
    var wordToSearch: String = ""
    
    func fetchTranslation(for word: String) {
        wordToSearch = word
        
        if let webURL = URL(string: "https://www.deepl.com/translator#en/ru/\(wordToSearch)") {
            do {
                let HTMLString = try String(contentsOf: webURL, encoding: .utf8)
                let document = try SwiftSoup.parse(HTMLString)
                let mainSection = try document.getElementsByClass("target-dummydiv").first()
                wordTranslation = try mainSection?.text() ?? "Could not find translation"
            } catch {
                wordTranslation = "Could not find translation"
            }
        }
    }
    var classWithTranslationValue = "Q4iAWc"
}
