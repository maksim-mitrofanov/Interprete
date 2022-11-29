//
//  DictionaryComDataParser.swift
//  Interprete
//
//  Created by Максим Митрофанов on 21.05.2022.
//

import Foundation
import SwiftSoup
import AppKit

class DictionaryComDataParser: ObservableObject {
    @Published var mainWordDefinition: String = ""
    @Published var otherWordDefinitions: [String] = []
    var wordToSearch: String = "" {
        didSet {
            if isReal(word: wordToSearch) { fetchAllDefinitions() }
            else { mainWordDefinition = "Unfortunately, this word could not be found in dictionary." }
        }
    }
    
    private func fetchAllDefinitions() {
        resetDefinitions()
        
        DispatchQueue.main.async { [self] in
            let urlForWordAsString = "https://www.dictionary.com/browse/\(wordToSearch.lowercased())"
            
            //Class names
            let baseClassName = "css-1avshm7 e16867sm0"
            let definitionClassName = "one-click-content css-nnyc96 e1q3nk1v1"
            
            do {
                guard let webURL = URL(string: urlForWordAsString) else { return }
                let HTMLString = try String(contentsOf: webURL, encoding: .utf8)
                let document = try SwiftSoup.parse(HTMLString)
                let mainSection = try document.getElementsByClass(baseClassName).first()
                if let definitions = try mainSection?.getElementsByClass(definitionClassName) {
                    updateDefinitions(with: definitions)
                }
            } catch {
                mainWordDefinition = "Unfortunately, there was an error getting a definition for this word."
            }
        }
    }
    
    func resetDefinitions() {
        mainWordDefinition = ""
        otherWordDefinitions = []
    }
    
    private func isReal(word: String) -> Bool {
        let checker = NSSpellChecker()
        return checker.checkSpelling(of: word, startingAt: 0).location == NSNotFound
    }
    
    private func updateDefinitions(with elements: Elements) {
        do {
            var index = 1
            try elements.forEach { element in
                if mainWordDefinition.isEmpty { mainWordDefinition = try element.text().firstLetterUp() }
                else if index <= 6 { otherWordDefinitions.append(try element.text().firstLetterUp()); index += 1}
            }
        } catch {
            
        }
    }
    
    //MARK: -Inits
    init() { }
    
    init(with word: String) { wordToSearch = word }
}


extension String {
    func firstLetterUp() -> String {
        var mainText = self
        let firstChar = self.first?.uppercased() ?? ""
        mainText.removeFirst()
        
        return "\(firstChar + mainText)"
        
    }
}
