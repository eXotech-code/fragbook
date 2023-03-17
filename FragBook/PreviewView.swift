//
//  PreviewView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import SwiftUI

struct PreviewView: View {
    public var code: Binding<String>
    
    init(_ code: Binding<String>) {
        self.code = code
    }
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            HStack {
                RenderedView(code)
                    .aspectRatio(1.0, contentMode: .fit)
                    .padding()
            }
        }
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(
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
