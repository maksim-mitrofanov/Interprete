//
//  DefinitionSection.swift
//  Interprete
//
//  Created by Максим Митрофанов on 28.05.2022.
//

import SwiftUI

struct DefinitionSection: View {
    let topText: String
    let definitions: [String]
    
    var body: some View {
        VStack {
            HStack {
                Text(topText)
                    .bold()
                    .font(.title2)
                
                Spacer()
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    ForEach(definitions, id: \.self) { definition in
                        if definitions.last != definition {
                            Text("\(definition)\n")
                        } else {
                            Text("\(definition)")
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}
