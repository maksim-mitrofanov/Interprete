//
//  ContentView.swift
//  Interprete
//
//  Created by Максим Митрофанов on 21.05.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dataSource: DictionaryComDataParser
    var camDictionary = CambridgeDictionaryDataParser(word: "magic")
    @State var wordToSearch: String = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    //MARK: -Body
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading) {
                    textFieldAndButtonRow
                    definitions
                }
                .padding()
            }
        }
        .onChange(of: wordToSearch) { _ in
            dataSource.resetDefinitions()
        }
    }
    
    var background: some View {
        ZStack {
            colorScheme == .light ? Color.white : Color.black
            
            VStack {
                Divider()
                Spacer()
            }
        }
    }
    
    //MARK: -TextField And Button
    var textFieldAndButtonRow: some View {
        HStack {
            wordToSearchField
            findDefinitionButton
        }
        .font(.title2)
        .padding(.bottom)
    }
    
    var wordToSearchField: some View {
        TextField("Word to search", text: $wordToSearch)
            .textFieldStyle(.plain)
            .doubleRoundedBackground(
                color: DrawingConstants.defMainColor,
                cornerRadius: DrawingConstants.defMaxCornerRadius,
                lineWidth: DrawingConstants.defBorderLineWidth,
                paddingScale: DrawingConstants.defPaddingScale
            )
    }
    
    var findDefinitionButton: some View {
        Button {
            withAnimation {
                dataSource.wordToSearch = wordToSearch
            }
        } label: {
            Image(systemName: "magnifyingglass")
                .aspectRatio(DrawingConstants.defAspectRatio, contentMode: .fit)
        }
        .buttonStyle(DrawingConstants.defButtonStyle)
    }
    
    //MARK: -Definitions
    var definitions: some View {
        VStack {
            if !dataSource.mainWordDefinition.isEmpty {
                mainDefinitionView
                otherDefinitionsView
            }
        }
        .animation(.easeInOut, value: dataSource.mainWordDefinition.isEmpty)
    }
    
    
    
    var mainDefinitionView: some View {
        DefinitionSection(topText: dataSource.wordToSearch, definitions: [dataSource.mainWordDefinition])
            .roundedBackground(color: DrawingConstants.defSecondaryColor, cornerRadius: DrawingConstants.defMinCornerRadius)
        .padding(.top)
    }
    
    var otherDefinitionsView: some View {
        DefinitionSection(topText: "Other definitions:", definitions: dataSource.otherWordDefinitions)
            .roundedBackground(color: DrawingConstants.defSecondaryColor, cornerRadius: DrawingConstants.defMinCornerRadius)
        .padding(.top)
    }
    
    //MARK: -DrawingConstants
    struct DrawingConstants {
        static var defMainColor: Color = Color.blue.opacity(0.2)
        static var defSecondaryColor: Color = Color.gray.opacity(0.2)
        
        static var defMinCornerRadius: CGFloat = 5
        static var defMaxCornerRadius: CGFloat = 12
        
        
        static var defAspectRatio: CGFloat = 1/1
        static var defBorderLineWidth: CGFloat = 3
        static var defPaddingScale: CGFloat = 8
        
        static var defButtonStyle: DoubleRoundedButtonStyle =
        DoubleRoundedButtonStyle(
            color: DrawingConstants.defMainColor,
            cornerRadius: DrawingConstants.defMaxCornerRadius,
            lineWidth: DrawingConstants.defBorderLineWidth,
            paddingScale: DrawingConstants.defPaddingScale)
    }
}


struct ContentView_Previews: PreviewProvider {
    static let firstDataStore = DictionaryComDataParser(with: "Imagination")
    static let secondDataStore = DictionaryComDataParser(with: "Military")
    static let thirdDataStore = DictionaryComDataParser(with: "Job")

    
    
    static var previews: some View {
        ContentView(dataSource: firstDataStore, wordToSearch: "Imagination")
            .frame(width: 350, height: 600)
            .padding()
        
        ContentView(dataSource: secondDataStore, wordToSearch: "Military")
            .frame(width: 350, height: 600)
            .padding()
        
        ContentView(dataSource: thirdDataStore, wordToSearch: "Job")
            .frame(width: 350, height: 600)
            .padding()
    }
}
