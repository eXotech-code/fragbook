//
//  Renderer.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    var parent: RenderedView?
    var metalDevice: MTLDevice!
    var pipelineState: MTLRenderPipelineState!
    var metalCommandQueue: MTLCommandQueue!
    let vertexBuffer: MTLBuffer
    
    init(fragCode: String) {
        self.parent = nil
        
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            self.metalDevice = metalDevice
        }
        self.metalCommandQueue = metalDevice.makeCommandQueue()
        
        let vertices = [
            Vertex(position: [-1, -1], color: [1, 0, 0, 1]),
            Vertex(position: [1, -1], color: [0, 1, 0, 1]),
            Vertex(position: [0, 1], color: [0, 0, 1, 1])
        ]
        
        vertexBuffer = metalDevice.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride, options: [])!
        
        super.init()
    }
    
    func setParent(_ parent: RenderedView) {
        self.parent = parent
    }
    
    func createPipelineState(with: String) {
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        let defaultLibrary = metalDevice.makeDefaultLibrary()
        let fragmentLibrary = try? metalDevice.makeLibrary(
            source: with,
            options: nil
        )
        let fragmentFunction = fragmentLibrary?.makeFunction(name: "fragmentShader")
        
        pipelineDescriptor.vertexFunction = defaultLibrary?.makeFunction(name: "vertexShader")
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        let state: MTLRenderPipelineState
        do {
            state = try metalDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError("Unable to create render pipeline descriptor.")
        }
        
        self.pipelineState = state
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
        renderPassDescriptor?.colorAttachments[0].clearColor = MTLClearColor(red: 0, green: 0.0, blue: 0.0, alpha: 1.0)
        renderPassDescriptor?.colorAttachments[0].loadAction = .clear
        renderPassDescriptor?.colorAttachments[0].storeAction = .store
        
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor!)
        renderEncoder?.setRenderPipelineState(pipelineState)
        renderEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        renderEncoder?.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
