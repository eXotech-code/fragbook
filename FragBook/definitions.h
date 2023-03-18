//
//  definitions.h
//  FragBook
//
//  Created by Jakub Piskiewicz on 16/03/2023.
//

#ifndef definitions_h
#define definitions_h

#include <simd/simd.h>

struct Vertex {
    vector_float2 position;
    vector_float2 textureCoordinate;
};

// Unforms used by the fragment shader
struct Uniforms {
    float time;
};

#endif /* definitions_h */
