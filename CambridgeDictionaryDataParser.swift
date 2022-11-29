//
//  CambridgeDictionaryDataParser.swift
//  Interprete
//
//  Created by Максим Митрофанов on 29.05.2022.
//

import Foundation
import SwiftSoup

class CambridgeDictionaryDataParser {
    var defintions: [String] = []
    
    func fetchDefinitions(for word: String) {
        defintions.removeAll()
        let definitionClassName = "def ddef_d db"
        
        DispatchQueue.main.async { 
            do {
                guard let webURL = URL(string: "https://dictionary.cambridge.org/dictionary/english/\(word)") else { return }
                let HTMLString = try String(contentsOf: webURL, encoding: .utf8)
                let document = try SwiftSoup.parse(HTMLString)
                let mainSection = try document.getElementsByClass(definitionClassName)
                print("Number of definitions: \(mainSection.count)")
            } catch {
                
            }
        }
    }
    
    init(word: String) {
        fetchDefinitions(for: word)
    }
}
