// uniform vec3 atmosphereColor;

// varying vec3 vertexNormal;

// void main() {
//     float intensity = 0.5 - dot(vertexNormal, vec3(0.0, 0.0, 1.0));
//     vec3 atmosphere = vec3(atmosphereColor) * pow(intensity, 1.5);

//     gl_FragColor = vec4(atmosphere, 1.0);
// }

// SOURCE: https://github.com/boyaquito/abovetheclouds/tree/master

uniform vec4 uColor;
varying vec3 vNormal;
varying float intensity;
uniform bool usingDirectionalLighting;

uniform vec3 directionalLightDirection;

void main() {

    vec3 dirDiffuse = vec3( 0.0 );
    vec3 dirSpecular = vec3( 0.0 );

    if ( usingDirectionalLighting ) {

            vec4 lDirection = viewMatrix * vec4( directionalLightDirection, 0.0 );
            vec3 dirVector = normalize( lDirection.xyz );
            
            float directionalLightWeightingFull = max( dot( vNormal, dirVector ), 0.0 );
            float directionalLightWeightingHalf = max( 10.0 * dot( vNormal, dirVector ) + 0.5, 0.0 );
            vec3 dirDiffuseWeight = mix( vec3( directionalLightWeightingFull ), vec3( directionalLightWeightingHalf ), uColor.xyz );

            dirDiffuse += dirDiffuseWeight;

    } else {

        dirDiffuse = vec3( 1.0 );

    }

    gl_FragColor = intensity * intensity * vec4( dirDiffuse, 1.0 );

}