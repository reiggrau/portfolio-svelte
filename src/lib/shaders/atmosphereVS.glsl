varying vec3 vertexNormal;

void main() {
    vertexNormal = normalize( normalMatrix * normal );
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
}

// varying vec3 vertexNormal;
// varying vec3 vertexPosition;

// void main() {
//     vertexNormal = normalize( normalMatrix * normal );
//     gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
//     vertexPosition = gl_Position.xyz;
// }

// varying vec3 vVertexWorldPosition;
// varying vec3 vVertexNormal;

// void main(){

//     vVertexNormal = normalize( normalMatrix * normal );
//     vVertexWorldPosition = ( modelMatrix * vec4( position, 1.0 ) ).xyz;
//     gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );

// }