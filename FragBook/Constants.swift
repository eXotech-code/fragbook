//
//  Constants.swift
//  FragBook
//
//  Created by Jakub Piskiewicz on 17/03/2023.
//

let initialShader = """
struct Fragment {
    float4 position [[position]];
    float4 color;
};

fragment float4 fragmentShader(Fragment input [[stage_in]]) {
    return input.color;
}
"""
