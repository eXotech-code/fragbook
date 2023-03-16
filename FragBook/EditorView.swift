//
//  EditorView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import SwiftUI

struct EditorView: View {
    @State private var code: String = """
    #version 460

    out vec4 fragColor;
    
    void main() {
        fragColor = vec4(1.0, 0.0, 0.0, 1.0);
    }
    """
    
    var body: some View {
        TextEditor(text: $code)
            .monospaced()
            .padding()
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
    }
}
