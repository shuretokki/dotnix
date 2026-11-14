#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 itemSize;
    float cornerR;
};

float sdRoundRect(vec2 p, vec2 halfSize, float r)
{
    vec2 q = abs(p) - halfSize + r;
    return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - r;
}

void main()
{
    vec2 p = qt_TexCoord0 * itemSize;
    vec2 c = itemSize * 0.5;
    vec2 rel = p - c;
    float d = sdRoundRect(rel, c, cornerR);
    float inside = 1.0 - smoothstep(-0.3, 0.6, d);

    float line = exp(-max(-d, 0.0) / 1.1) * inside;
    float sheen = exp(-max(-d, 0.0) / 7.0) * inside;

    vec2 dir = normalize(rel + vec2(0.0001));
    float key = dot(dir, normalize(vec2(-0.55, -0.83)));
    float lit = pow(max(key, 0.0), 1.4);
    float bounce = pow(max(-key, 0.0), 2.5);

    float a = line * (0.08 + 0.42 * lit + 0.18 * bounce) + sheen * (0.07 * lit + 0.02 * bounce);
    a = clamp(a, 0.0, 1.0);

    fragColor = vec4(vec3(a), a) * qt_Opacity;
}
