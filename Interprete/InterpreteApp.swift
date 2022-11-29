//
//  InterpreteApp.swift
//  Interprete
//
//  Created by Максим Митрофанов on 21.05.2022.
//

import SwiftUI

@main
struct InterpreteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(dataSource: DictionaryComDataParser())
                .frame(minWidth: 350, minHeight: 600)
        }
    }
}
