//
//  StatusView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 17/03/2023.
//

import SwiftUI

struct StatusView: View {
    @EnvironmentObject var dataModel: DataModel
    
    func getStatusMessage() -> String {
        switch dataModel.status {
        case .compiled:
            return "Compiled"
        case .compiling:
            return "Compiling shader"
        case .error:
            return "Compilation failed"
        }
    }
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .ignoresSafeArea()
            HStack {
                Text(getStatusMessage())
                StatusIndicatorView()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(height: 16)
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
