//
//  RenderedView.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import SwiftUI
import MetalKit

struct RenderedView: UIViewRepresentable {
    public var code: Binding<String>
    let coordinator: Renderer
    
    init(_ code: Binding<String>) {
        self.code = code
        coordinator = Renderer(fragCode: code.wrappedValue)
    }
    
    func makeCoordinator() -> Renderer {
        coordinator.setParent(self)
        coordinator.createPipelineState(with: code.wrappedValue)
        return coordinator
    }
    
    func makeUIView(context: UIViewRepresentableContext<RenderedView>) -> MTKView {
        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = true
        
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }
        
        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size
        
        return mtkView
    }
    
    func updateUIView(_ uiView: MTKView, context: UIViewRepresentableContext<RenderedView>) {
        // Replace the old shader code with the current one.
        coordinator.createPipelineState(with: code.wrappedValue)
    }
}

struct RenderedView_Previews: PreviewProvider {
    static var previews: some View {
        RenderedView(
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
