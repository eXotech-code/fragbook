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
    @Published var time: Float = 0
    let clock: ContinuousClock
    var startTime: ContinuousClock.Instant
    
    init() {
        let clock = ContinuousClock()
        self.startTime = clock.now
        self.clock = clock
        self.compileShader(newCode: initialShader)
        self.startRefreshingTime()
    }
    
    func compileShader(newCode: String) {
        self.status = .compiling
        self.resetTime()
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
    
    func resetTime() {
        self.startTime = self.clock.now;
    }
    
    func getTime() -> Float {
        let components = self.startTime.duration(to: self.clock.now).components
        let seconds = Float(components.seconds)
        let attoseconds = Float(components.attoseconds)
        return seconds + attoseconds * pow(10, -18)
    }
    
    func startRefreshingTime() {
        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true, block: { _ in
            self.time = self.getTime()
        })
    }
}
