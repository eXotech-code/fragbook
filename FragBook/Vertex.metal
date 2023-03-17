//
//  Vertex.metal
//  FragBook
//
//  Created by Jakub Piskiewicz on 17/03/2023.
//

#include <metal_stdlib>
using namespace metal;

#include "definitions.h"

struct RasterizerData {
    float4 position [[position]];
    float2 textureCoordinate;
};

vertex RasterizerData vertexShader(
    const device Vertex *vertexArray [[buffer(0)]],
    unsigned int vertexID [[vertex_id]]
) {
    Vertex input = vertexArray[vertexID];
    
    RasterizerData out;
    out.position = float4(input.position.x, input.position.y, 0, 1);
    out.textureCoordinate = input.textureCoordinate;
    
    return out;
}
