#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 itemSize;
    float cornerR;
};

layout(binding = 1) uniform sampler2D source;

float sdRoundRect(vec2 p, vec2 halfSize, float r)
{
    vec2 q = abs(p) - halfSize + r;
    return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - r;
}

void main()
{
    vec4 c = texture(source, qt_TexCoord0);
    vec2 halfSize = itemSize * 0.5;
    float d = sdRoundRect(qt_TexCoord0 * itemSize - halfSize, halfSize, cornerR);
    float m = 1.0 - smoothstep(-0.5, 0.5, d);
    fragColor = c * m * qt_Opacity;
}
