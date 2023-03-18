//
//  EditorView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Value) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = handler(newValue)
            }
        )
    }
}

struct EditorView: View {
    @EnvironmentObject var dataModel: DataModel
    @State var code = initialCodeValue
    
    var body: some View {
        VStack {
            TextEditor(text: $code.onChange(dataModel.setCode))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .monospaced()
                .padding(.leading)
                .onAppear(perform: {
                    code = dataModel.setCode(code)
                    
                })
            StatusView()
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
    }
}
