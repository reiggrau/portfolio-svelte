<script lang="ts">
    import * as THREE from 'three';
    import { T, useTask, useLoader  } from '@threlte/core';
    import { useSuspense, useTexture } from '@threlte/extras';

    import vertexShader from '$lib/shaders/vertexShader.glsl?raw';
	import fragmentShader from '$lib/shaders/fragmentShader.glsl?raw';
	import atmosphereVS from '$lib/shaders/atmosphereVS.glsl?raw';
	import atmosphereFS from '$lib/shaders/atmosphereFS.glsl?raw';

    export let position: [ number, number, number ];

    const suspend = useSuspense();

    // Textures
	const earthTexture = suspend(useTexture('/textures/bodies/earth_16k_edited6_-30saturation.jpg', {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	}));
	const earthBump = useLoader(THREE.TextureLoader).load('/textures/bodies/earth_topography_16k.jpg');
	const earthSpecular = useLoader(THREE.TextureLoader).load('/textures/bodies/earth_specular_inverted_gray.png');
	const earthClouds = useTexture('/textures/bodies/earth_clouds_16k_brightness-30.jpg', {
		transform: (texture) => {
			texture.anisotropy = 4;
			texture.wrapS = THREE.RepeatWrapping;
			texture.wrapT = THREE.RepeatWrapping;
			return texture;
		}
	});
	const earthLights = useTexture('/textures/bodies/earth_lights.jpg', {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});

    // Animation
    let rotation = 0;
	useTask((delta) => {
		rotation += delta;
		if ($earthClouds) {
			$earthClouds.offset.set(0.4 - (rotation / 5000), 0 );
		}
	});
</script>

{#await earthTexture then}
	<T.Group
		{position}
	>
		<!-- Earth surface -->
		<T.Mesh
			scale={1}
            rotation.x={(23.4 * Math.PI / 180) * 1}
			rotation.y={2.4 + (rotation / 100)}
		>
			<T.IcosahedronGeometry args={[7.9, 64]}/>
			<T.MeshStandardMaterial color={0xffffff} map={$earthTexture} bumpMap={$earthBump} bumpScale={2} roughnessMap={$earthSpecular} roughness={0.99} displacementMap={$earthBump} displacementScale={0.01} lightMap={$earthClouds} lightMapIntensity={-1}/>
		</T.Mesh>

		<!-- City lights -->
		<!-- <T.Mesh
			scale={1}
			rotation.y={0.5 + rotation / 200}
			rotation.x={23.4 * Math.PI / 180}
		>
			<T.IcosahedronGeometry args={[3, 64]}/>
			<T.MeshStandardMaterial map={$earthLights} blending={THREE.AdditiveBlending}/>
		</T.Mesh> -->

		<!-- Clouds -->
		<T.Mesh
			scale={1.004}
			rotation.x={23.4 * Math.PI / 180}
			rotation.y={2.4 + (rotation / 100)}
		>
			<T.IcosahedronGeometry args={[7.9, 64]}/>
			<T.MeshStandardMaterial color={'white'} alphaMap={$earthClouds} bumpMap={$earthClouds} bumpScale={0.1} transparent/>
		</T.Mesh>

		<!-- Sky effect -->
		<!-- <T.Mesh
			scale={1.004}
			rotation.x={23.4 * Math.PI / 180}
			rotation.y={2.4 + (rotation / 100)}
		>
			<T.IcosahedronGeometry args={[7.9, 64]}/>
			<T.ShaderMaterial
				{vertexShader}
				{fragmentShader}
				uniforms={{
					atmosphereColor: { value: new THREE.Color(0x87CEEB) }
				}}
				blending={THREE.AdditiveBlending}
				transparent={true}
			/>
		</T.Mesh> -->

		<!-- <T.Mesh
			scale={1.004}
			rotation.y={0.5 + rotation / 200}
			rotation.x={23.4 * Math.PI / 180}
		>
			<T.IcosahedronGeometry args={[3, 64]}/>
			<T.ShaderMaterial
				{uniforms}
				{vertexShader}
				{fragmentShader}
				transparent
				blending={THREE.AdditiveBlending}
				depthWrite={false}
				depthTest
				needsUpdate
				lights
			/>
		</T.Mesh> -->

		<!-- Atmosphere effect -->
		<!-- <T.Mesh
			scale={2}
		>
			<T.SphereGeometry/>
			<T.ShaderMaterial
				vertexShader={atmosphereVS}
				fragmentShader={atmosphereFS}
				uniforms={{
					atmosphereColor: { value: new THREE.Color(0x38bdf8) }
				}}
				side={THREE.BackSide}
				blending={THREE.AdditiveBlending}
				transparent={true}
			/>
		</T.Mesh> -->
	</T.Group>
{/await}