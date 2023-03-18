//
//  Constants.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 17/03/2023.
//

let initialShader = """
#include <metal_stdlib>
using namespace metal;

struct Uniforms {
    float time;
};

struct RasterizerData {
    float4 position [[position]];
    float2 textureCoordinate;
};

fragment float4 fragmentShader(constant Uniforms &uniforms [[buffer(0)]], RasterizerData in [[stage_in]]) {
    float time = uniforms.time;
    float2 pos = in.textureCoordinate;

    return float4(float3(pos.x), 1.0);
}
"""

let initialCodeValue = "INITIAL"
