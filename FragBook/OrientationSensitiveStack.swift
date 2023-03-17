//
//  OrientationSensitiveStack.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import SwiftUI

struct OrientationSensitiveStack: View {
    @EnvironmentObject var dataModel: DataModel
    @Binding public var orientation: UIDeviceOrientation
    let editor: EditorView
    let preview: PreviewView
    
    var body: some View {
        if orientation.isLandscape {
            HStack {
                self.editor
                self.preview
                        .frame(width: 400)
            }
        } else {
            VStack {
                self.preview
                    .frame(height: 200)
                self.editor
            }
        }
    }
}

struct OrientationSensitiveStack_Previews: PreviewProvider {
    static var previews: some View {
        OrientationSensitiveStack(
            orientation: .constant(UIDeviceOrientation.landscapeLeft),
            editor: EditorView(),
            preview: PreviewView()
        )
    }
}
