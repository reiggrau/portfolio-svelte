uniform vec3 color;
uniform float aperture;
uniform float scale;
uniform float opacity;

varying vec3 vVertexNormal;
varying vec3 vVertexWorldPosition;

void main() {

    vec3 worldCameraToVertex = vVertexWorldPosition - cameraPosition;
    vec3 viewCameraToVertex = ( viewMatrix * vec4( worldCameraToVertex, 0.0 ) ).xyz;
    viewCameraToVertex	= normalize( viewCameraToVertex );
    float intensity = pow( aperture + dot( vVertexNormal, viewCameraToVertex ), scale );
    gl_FragColor = vec4( color, intensity ) * opacity;

}