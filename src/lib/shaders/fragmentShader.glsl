uniform vec3 atmosphereColor;

varying vec3 vertexNormal;

void main() {
    float intensity = 1.0 - dot(vertexNormal, vec3(0.0, 0.0, 1.0));
    vec3 atmosphere = vec3(atmosphereColor) * pow(intensity, 1.5);

    gl_FragColor = vec4(atmosphere, 1.0);
}
