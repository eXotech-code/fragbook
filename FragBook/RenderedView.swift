//
//  RenderedView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import MetalKit
import SwiftUI

struct RenderedView: UIViewRepresentable {
    @EnvironmentObject var dataModel: DataModel
    
    func makeCoordinator() -> Renderer {
        Renderer(parent: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<RenderedView>) -> MTKView {
        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = false
        mtkView.isPaused = false
        
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }
        
        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size
        
        return mtkView
    }
    
    func updateUIView(_ uiView: MTKView, context: UIViewRepresentableContext<RenderedView>) {
        uiView.setNeedsDisplay()
    }
}

struct RenderedView_Previews: PreviewProvider {
    static var previews: some View {
        RenderedView()
    }
}
