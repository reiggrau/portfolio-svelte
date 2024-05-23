uniform sampler2D globeTexture;
uniform bool hasAtmosphere;
uniform vec3 atmosphereColor;

varying vec2 vertexUV;
varying vec3 vertexNormal;

void main() {
    if (hasAtmosphere) {
        float intensity = 1.05 - dot(vertexNormal, vec3(0.0, 0.0, 1.0));
        vec3 atmosphere = vec3(atmosphereColor) * pow(intensity, 1.5);

        gl_FragColor = vec4(atmosphere + texture2D(globeTexture, vertexUV).xyz, 1.0);
    } else {
        gl_FragColor = texture2D(globeTexture, vertexUV);
    }
}
