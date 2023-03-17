//
//  Vertex.metal
//  FragBook
//
//  Created by Jakub Piskiewicz on 17/03/2023.
//

#include <metal_stdlib>
using namespace metal;

#include "definitions.h"

struct Fragment {
    float4 position [[position]];
    float4 color;
};

vertex Fragment vertexShader(
    const device Vertex *vertexArray [[buffer(0)]],
    unsigned int vid [[vertex_id]]
) {
    Vertex input = vertexArray[vid];
    
    Fragment output;
    output.position = float4(input.position.x, input.position.y, 0, 1);
    output.color = input.color;
    
    return output;
}
