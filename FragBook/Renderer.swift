//
//  Renderer.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

import MetalKit

func createTimeBuffer(_ parent: RenderedView, currentTime: Float) -> MTLBuffer {
    let bufferSize = MemoryLayout<Float>.size
    let buffer = parent.dataModel.metalDevice.makeBuffer(length: bufferSize, options: [])!

    return buffer
}

class Renderer: NSObject, MTKViewDelegate {
    var parent: RenderedView
    var metalCommandQueue: MTLCommandQueue!
    let vertexBuffer: MTLBuffer
    let indexBuffer: MTLBuffer
    let timeBuffer: MTLBuffer
    
    init(parent: RenderedView) {
        self.parent = parent
        
        self.metalCommandQueue = parent.dataModel.metalDevice.makeCommandQueue()
        
        let vertices = [
            Vertex(position: [-1, -1], textureCoordinate: [0.0, 1.0]),
            Vertex(position: [1, -1], textureCoordinate: [1.0, 1.0]),
            Vertex(position: [1, 1], textureCoordinate: [1.0, 0.0]),
            Vertex(position: [-1, 1], textureCoordinate: [0.0, 0.0])
        ]
        
        self.vertexBuffer = parent.dataModel.metalDevice.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride, options: [])!
        
        let indices: Array<UInt16> = [
            0, 1, 3,
            1, 2, 3
        ]
        
        self.indexBuffer = parent.dataModel.metalDevice.makeBuffer(bytes: indices, length: indices.count * MemoryLayout<UInt16>.stride, options: [])!
        self.timeBuffer = createTimeBuffer(parent, currentTime: parent.dataModel.getTime())
        super.init()
        setDataModelUniforms(self.timeBuffer)
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
    
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
        renderEncoder?.setRenderPipelineState(parent.dataModel.pipelineState!)
        renderEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder?.setFragmentBuffer(self.timeBuffer, offset: 0, index: 0)
        renderEncoder?.drawIndexedPrimitives(type: .triangle, indexCount: 6, indexType: .uint16, indexBuffer: self.indexBuffer, indexBufferOffset: 0)
        renderEncoder?.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
    
    func setDataModelUniforms(_ timeBuffer: MTLBuffer) {
        let uniforms = UnsafeMutableRawPointer(timeBuffer.contents())
            .bindMemory(to: Uniforms.self, capacity: 1)
        self.parent.dataModel.setUniforms(uniforms)
    }
}
