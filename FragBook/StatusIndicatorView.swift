//
//  StatusIndicatorView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 17/03/2023.
//

import SwiftUI

struct StatusIndicatorView: View {
    @EnvironmentObject var dataModel: DataModel
    
    var body: some View {
        Group {
            switch dataModel.status {
            case .compiled:
                Circle()
                    .foregroundColor(.green)
            case .compiling:
                Circle()
                    .foregroundColor(.yellow)
            case .error:
                Circle()
                    .foregroundColor(.red)
            }
        }
        .frame(width: 16)
    }
}

struct StatusIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        StatusIndicatorView()
    }
}
