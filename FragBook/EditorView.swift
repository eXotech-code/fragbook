//
//  EditorView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

struct EditorView: View {
    @EnvironmentObject var dataModel: DataModel
    @State var code: String = initialShader
    
    var body: some View {
        VStack {
            TextEditor(text: $code.onChange(dataModel.compileShader))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .monospaced()
                .padding(.leading)
            StatusView()
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
    }
}
