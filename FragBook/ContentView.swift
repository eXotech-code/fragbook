//
//  ContentView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State public var orientation = UIDeviceOrientation.landscapeLeft
    @State public var code = """
    fragment float4 fragmentShader() {
        return float4(1.0, 0.0, 0.0, 1.0);
    }
    """
    
    var body: some View {
        OrientationSensitiveStack(
            orientation: $orientation,
            editor: EditorView($code),
            preview: PreviewView($code)
        )
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIDevice.orientationDidChangeNotification
            )
        ) { _ in
            let newOrientation = UIDevice.current.orientation
            if !(newOrientation.isFlat || newOrientation == UIDeviceOrientation.unknown) {
                orientation = newOrientation
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
