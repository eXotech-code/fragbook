//
//  PreviewView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import SwiftUI

struct PreviewView: View {
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            HStack {
                RenderedView()
                    .aspectRatio(1.0, contentMode: .fit)
                    .padding()
            }
        }
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
