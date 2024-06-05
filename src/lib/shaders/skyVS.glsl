// varying vec2 vertexUV;
// varying vec3 vertexNormal;

// void main() {
//     vertexUV = uv;
//     vertexNormal = normalize(normalMatrix * normal);
//     gl_Position = projectionMatrix *
//     modelViewMatrix * vec4( position, 1.0 );
// }

uniform vec3 viewVector;
attribute vec4 tangent;
varying vec3 vNormal;
varying float intensity;
uniform float uTop;
uniform float uPower;

void main() {

    vNormal = normalize( normalMatrix * normal );
    vec3 vNormel = normalize( normalMatrix * viewVector );
    intensity = pow( uTop - dot(vNormal, vNormel), uPower );
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );

}
