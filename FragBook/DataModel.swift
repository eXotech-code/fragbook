//
//  DataModel.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 17/03/2023.
//

import SwiftUI
import MetalKit

enum Status {
    case compiled
    case compiling
    case error
}

class DataModel : ObservableObject {
    @Published var status: Status = .compiling
    @Published var metalDevice: MTLDevice = MTLCreateSystemDefaultDevice()!
    @Published var pipelineState: MTLRenderPipelineState!
    
    init() {
        compileShader(newCode: initialShader)
    }
    
    func compileShader(newCode: String) {
        self.status = .compiling
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        let defaultLibrary = metalDevice.makeDefaultLibrary()
        let fragmentLibrary = try? metalDevice.makeLibrary(
            source: newCode,
            options: nil
        )
        let fragmentFunction = fragmentLibrary?.makeFunction(name: "fragmentShader")
        if fragmentFunction == nil {
            self.status = .error
        } else {
            self.status = .compiled
        }
        
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
}
