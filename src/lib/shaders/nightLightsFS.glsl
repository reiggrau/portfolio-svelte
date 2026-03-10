uniform sampler2D lightsMap;
uniform vec3 sunDirection;
uniform float intensity;

varying vec2 vUv;
varying vec3 vNormalWorld;

void main() {
    vec3 sunDir = normalize(sunDirection);
    float sunDot = dot(vNormalWorld, sunDir);

    // Lights fully visible on dark side (sunDot < -0.1),
    // soft fade across the terminator (-0.1 to 0.2),
    // invisible on day side (sunDot > 0.2)
    float nightFactor = 1.0 - smoothstep(-0.1, 0.2, sunDot);

    vec4 lightsColor = texture2D(lightsMap, vUv);

    // Cut the faint blue background of the texture — only bright city lights pass through
    float luminance = dot(lightsColor.rgb, vec3(0.299, 0.587, 0.114));
    float mask = smoothstep(0.05, 0.15, luminance);
    vec3 masked = lightsColor.rgb * mask;

    gl_FragColor = vec4(masked * nightFactor * intensity, mask * nightFactor);
}
