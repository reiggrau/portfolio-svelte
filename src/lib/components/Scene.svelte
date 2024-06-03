<!-- https://threlte.xyz/docs/learn/getting-started/your-first-scene -->

<script lang='ts'>
	import * as THREE from 'three';
	import { TextureLoader } from 'three';
	import { T, useTask, useLoader } from '@threlte/core';
	import { interactivity, OrbitControls, Stars, SoftShadows, Suspense, Text, useSuspense, useTexture } from '@threlte/extras';
	import { spring } from 'svelte/motion';

	import { darkmode } from '$lib/store';

	import vertexShader from '$lib/shaders/vertexShader.glsl?raw';
	import fragmentShader from '$lib/shaders/fragmentShader.glsl?raw';
	import atmosphereVS from '$lib/shaders/atmosphereVS.glsl?raw';
	import atmosphereFS from '$lib/shaders/atmosphereFS.glsl?raw';

	// Postprocess
	import { useThrelte, useRender } from '@threlte/core';
    import {
        EffectComposer,
        EffectPass,
        RenderPass,
        SMAAEffect,
        SMAAPreset,
        BloomEffect,
        KernelSize
    } from 'postprocessing';
	import Renderer from './Renderer.svelte';

	// Textures
	// Earth
	// const earthTexture = useLoader(TextureLoader).load('/textures/bodies/earth_16k_edited6.jpg');
	const earthTexture = useTexture('/textures/bodies/earth_16k_edited6_-50saturation.jpg', {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});
	const earthBump = useLoader(TextureLoader).load('/textures/bodies/earth_topography_16k.jpg');
	const earthSpecular = useLoader(TextureLoader).load('/textures/bodies/earth_specular_inverted_gray.png');
	const earthClouds = useTexture('/textures/bodies/earth_clouds_16k_brightness75.jpg', {
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

	// Moon
	const moonTexture = useTexture('/textures/bodies/moon_8k.jpg', {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});
	const moonDisplacement = useLoader(TextureLoader).load('/textures/bodies/moon_displacement.jpg');

	// Interactivity
	interactivity();

	// Animation
	let rotation = 0;
	useTask((delta) => {
		rotation += delta;
		if ($earthClouds) {
			$earthClouds.offset.set(0.4 - (rotation / 5000), 0 );
		}
	});

	// Loading screen
	// const suspend = useSuspense();

	// Sky
	let color;
	let aperture;
	let scale;
	let useLight;

	// var _color = ( color === undefined ) ? new THREE.Color( '#95D3F4' ) : new THREE.Color( color );
	// var _aperture = ( aperture === undefined ) ? 0.9999999999 : aperture;
	// var _scale = ( scale === undefined ) ? 0.5555555555 : scale;
	// var _useLight = ( useLight === undefined ) ? true : useLight;

	// var vector = new THREE.Vector4( _color.r, _color.g, _color.b, 0.1 );

	// const uniforms = THREE.UniformsUtils.merge( [
	// 	THREE.UniformsLib[ "lights" ], {
	// 		"uColor": { type: "v4", value: vector },
	// 		"viewVector": { type: "v3", value: new THREE.Vector4( 1.0, 1.0, 1.0, 1.0 ) },
	// 		"uTop":  { type: "f", value: _aperture },//0.94 },
	// 		"uPower":  { type: "f", value: _scale },//0.65555555555 },
	// 		"usingDirectionalLighting": { type: "i", value: _useLight }
	// 	} ] );

</script>

<!-- Postprocess -->
<Renderer/>

<!-- Earth -->
{#if $earthTexture && $earthBump && $earthSpecular && $earthLights && $earthClouds}
	<T.Group
		position={[0, 0, 0]}
	>
		<!-- Earth surface -->
		<T.Mesh
			scale={1}
			rotation.y={0.5 + rotation / 200}
			rotation.x={23.4 * Math.PI / 180}
		>
			<T.IcosahedronGeometry args={[3, 64]}/>
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
			rotation.y={0.5 + rotation / 200}
			rotation.x={23.4 * Math.PI / 180}
		>
			<T.IcosahedronGeometry args={[3, 64]}/>
			<T.MeshStandardMaterial color={'white'} alphaMap={$earthClouds} bumpMap={$earthClouds} bumpScale={0.4} transparent/>
		</T.Mesh>

		<!-- Atmosphere -->
		<!-- Sky effect -->
		<!-- <T.Mesh
			scale={1.004}
			rotation.y={0.4 + rotation / 60}
			rotation.x={30 * Math.PI / 180}
		>
			<T.IcosahedronGeometry args={[3.01, 64]}/>
			<T.ShaderMaterial
				{vertexShader}
				{fragmentShader}
				uniforms={{
					atmosphereColor: { value: new THREE.Color(0xd1efff) }
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

		<!-- Halo effect -->
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
{/if}

<!-- Moon -->
{#if $moonTexture}
	<T.Mesh
		rotation.y={1.8}
		position={[5, 0, 0]}
	>
		<T.IcosahedronGeometry args={[1, 64]}/>
		<T.MeshStandardMaterial color={0xffffff} map={$moonTexture} bumpMap={$moonDisplacement} bumpScale={5} displacementMap={$moonDisplacement} displacementScale={0.01}/>
	</T.Mesh>
{/if}

<!-- Sun -->
<T.Mesh
	scale={1}
	position={[0, 0, 100]}
>
	<T.IcosahedronGeometry args={[1, 32]}/>
	<T.MeshStandardMaterial color={0xffffff} emissive={0xffffff} emissiveIntensity={10}/>
</T.Mesh>

<!-- Camera -->
<T.PerspectiveCamera position={[0, 0, 15]} zoom={1} fov={30} near={0.1} far={20000} makeDefault>
	<OrbitControls autoRotate={true} autoRotateSpeed={0} enableZoom={true} />
</T.PerspectiveCamera>

<!-- Ligh (Sun)-->
<T.DirectionalLight
	color={0xe8f7ff}
	intensity={4}
	position={[0, 0, 100]}
/>

<!-- Ligh (ambient) -->
<T.AmbientLight color={0x07215c} intensity={0.2}/>

<!-- Stars (Old version) -->
<!-- <Stars count={5000} depth={290} radius={50} speed={0} fade={false}/> -->

