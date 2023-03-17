//
//  Constants.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 17/03/2023.
//

let initialShader = """
#include <metal_stdlib>
using namespace metal;

struct RasterizerData {
    float4 position [[position]];
    float2 textureCoordinate;
};

fragment float4 fragmentShader(RasterizerData in [[stage_in]]) {
    return float4(float3(1.0 - in.textureCoordinate.y), 1.0);
}
"""
