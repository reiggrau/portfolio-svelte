// uniform vec3 atmosphereColor;

// varying vec3 vertexNormal;

// void main() {
//     float intensity = pow(0.7 - dot(vertexNormal, vec3(0, 0, 1.0)), 10.0);
//     gl_FragColor = vec4(0.3, 0.6, 1.0, 1.0) * intensity;
// }

// uniform vec3 atmosphereColor;

// varying vec3 vertexNormal;
// varying vec3 vertexPosition;

// void main() {
//     vec3 lightPosition = vec3(10.0, 10.0, 10.0);
//     vec3 lightDirection = normalize(lightPosition - vertexPosition);
//     float dotNL = clamp(dot(lightDirection, vertexNormal), 0.0, 1.0);

//     float intensity = pow(0.7 - dot(vertexNormal, vec3(0, 0, 1.0)), 10.0);
//     gl_FragColor = vec4(0.3, 0.6, 1.0, 1.0) * intensity * dotNL;
// }

uniform vec3 atmosphereColor;

varying vec3 vertexNormal;
varying vec3 vertexPosition;

void main() {
    vec3 lightPosition = vec3(10.0, 10.0, 10.0);
    vec3 lightDirection = normalize(lightPosition - vertexPosition);
    float dotNL = clamp(dot(lightDirection, vertexNormal), 0.0, 1.0);

    float intensity = pow( 0.8 - dot( vertexNormal, vec3( 0, 0, 1.0 ) ), 12.0 );
    // float intensity = pow(0.7 - dot(vertexNormal, vec3(0, 0, 1.0)), 10.0);
    // gl_FragColor = vec4(0.3, 0.6, 1.0, 1.0) * intensity;
    gl_FragColor = vec4( 1, 1.0, 1.0, 1.0 ) * intensity * dotNL;
}

// uniform vec3 color;
// uniform float aperture;
// uniform float scale;
// uniform float opacity;

// varying vec3 vVertexNormal;
// varying vec3 vVertexWorldPosition;

// void main() {

//     vec3 worldCameraToVertex = vVertexWorldPosition - cameraPosition;
//     vec3 viewCameraToVertex = ( viewMatrix * vec4( worldCameraToVertex, 0.0 ) ).xyz;
//     viewCameraToVertex	= normalize( viewCameraToVertex );
//     float intensity = pow( aperture + dot( vVertexNormal, viewCameraToVertex ), scale );
//     gl_FragColor = vec4( color, intensity ) * opacity;

// }