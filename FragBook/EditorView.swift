//
//  EditorView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import SwiftUI

struct EditorView: View {
    var code: Binding<String>
    
    init(_ code: Binding<String>) {
        self.code = code
    }
    
    var body: some View {
        TextEditor(text: self.code)
            .monospaced()
            .padding()
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView(
            .constant(
                    """
                    fragment float4 fragmentShader() {
                        return float4(1.0, 0.0, 0.0, 1.0);
                    }
                    """
            )
        )
    }
}
