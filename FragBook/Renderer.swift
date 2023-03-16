//
//  Renderer.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    let parent: RenderedView
    var metalDevice: MTLDevice!
    var metalCommandQueue: MTLCommandQueue!
    let vertexBuffer: MTLBuffer
    
    init(parent: RenderedView) {
        self.parent = parent
        
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            self.metalDevice = metalDevice
        }
        self.metalCommandQueue = metalDevice.makeCommandQueue()
        
        let vertices = [
            Vertex(position: [-1, -1], color: [1, 0, 0]),
            Vertex(position: [1, -1], color: [0, 1, 0]),
            Vertex(position: [1, 1], color: [1, 1, 1]),
            Vertex(position: [-1, 1], color: [0, 0, 1]),
        ]
        
        vertexBuffer = metalDevice.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride, options: [])!
        
        super.init()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable else {
            return // Nothing to draw
        }
        
        guard let commandBuffer = metalCommandQueue.makeCommandBuffer() else {
            return
        }
        let renderPassDescriptor = view.currentRenderPassDescriptor
        renderPassDescriptor?.colorAttachments[0].clearColor = MTLClearColor(red: 0, green: 0.5, blue: 0.5, alpha: 1.0)
        renderPassDescriptor?.colorAttachments[0].loadAction = .clear
        renderPassDescriptor?.colorAttachments[0].storeAction = .store
        
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor!)
        renderEncoder?.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
