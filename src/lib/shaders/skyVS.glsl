uniform vec3 viewVector;
attribute vec4 tangent;
varying vec3 vNormal;
varying float intensity;
uniform float uTop;
uniform float uPower;

void main() {
    vNormal = normalize( normalMatrix * normal );
    vec3 vNormel = normalize( normalMatrix * viewVector );
    intensity = pow( max(0.0, uTop - dot(vNormal, vNormel)), uPower );
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );

}
