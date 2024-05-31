<!-- https://threlte.xyz/docs/learn/getting-started/your-first-scene -->

<script lang='ts'>
	import * as THREE from 'three';
	import { TextureLoader } from 'three';
	import { T, useTask, useLoader } from '@threlte/core';
	import { interactivity, OrbitControls, Stars, SoftShadows, Suspense, Text, useSuspense } from '@threlte/extras';
	import { spring } from 'svelte/motion';

	import { darkmode } from '$lib/store';

	import { uniforms, fs, vs } from '../../getFresnelMat';

	import vertexShader from '$lib/shaders/vertexShader.glsl?raw';
	import fragmentShader from '$lib/shaders/fragmentShader.glsl?raw';
	import atmosphereVS from '$lib/shaders/atmosphereVS.glsl?raw';
	import atmosphereFS from '$lib/shaders/atmosphereFS.glsl?raw';

	// Postprocess

	// Textures
	// Earth
	const earthTexture = useLoader(TextureLoader).load('/textures/bodies/earth_16k_edited6.jpg');
	const earthBump = useLoader(TextureLoader).load('/textures/bodies/earth_topography_16k.jpg');
	// const earthNormal = useLoader(TextureLoader).load('/textures/bodies/earth_normal.png');
	const earthSpecular = useLoader(TextureLoader).load('/textures/bodies/earth_specular_inverted.png');
	const earthLights = useLoader(TextureLoader).load('/textures/bodies/earth_lights.jpg');
	const earthClouds = useLoader(TextureLoader).load('/textures/bodies/earth_clouds_16k_brightness75.jpg');

	// Moon
	const moonTexture = useLoader(TextureLoader).load('/textures/bodies/moon_8k.jpg');
	const moonDisplacement = useLoader(TextureLoader).load('/textures/bodies/moon_displacement.jpg');

	// Interactivity
	interactivity();

	// Animation
	let rotation = 48;
	useTask((delta) => {
		rotation += delta;
		if ($earthClouds) $earthClouds.offset.set( rotation / 8000, 0 );
	});

	// Loading screen
	// const suspend = useSuspense();

</script>

<!-- Earth -->
{#if $earthTexture && $earthBump && $earthSpecular && $earthLights && $earthClouds}
	<T.Group>
		<!-- Terrain -->
		<T.Mesh
			scale={1}
			position={[0, 0, 0]}
			rotation.y={0.5 + rotation / 200}
			rotation.x={23.4 * Math.PI / 180}
		>
			<T.IcosahedronGeometry args={[3, 64]}/>
			<T.MeshStandardMaterial map={$earthTexture} bumpMap={$earthBump} bumpScale={3} roughnessMap={$earthSpecular} displacementMap={$earthBump} displacementScale={0.01} lightMap={$earthClouds} lightMapIntensity={-1}/>
		</T.Mesh>

		<!-- City lights -->
		<!-- <T.Mesh
			scale={1}
			position={[0, 0, 0]}
			rotation.y={0.5 + rotation / 200}
			rotation.x={23.4 * Math.PI / 180}
		>
			<T.IcosahedronGeometry args={[3, 64]}/>
			{#if $earthLights}
				<T.MeshStandardMaterial color={'black'} transparent emissiveMap={$earthLights} emissiveIntensity={0.1} blending={THREE.AdditiveBlending}/>
			{/if}
		</T.Mesh> -->

		<!-- Clouds -->
		<T.Mesh
			scale={1.003}
			position={[0, 0, 0]}
			rotation.y={0.5 + rotation / 200}
			rotation.x={23.4 * Math.PI / 180}
		>
			<T.IcosahedronGeometry args={[3, 64]}/>
			<T.MeshStandardMaterial color={'white'} alphaMap={$earthClouds} bumpMap={$earthClouds} bumpScale={0.5} transparent/>
		</T.Mesh>

		<!-- Atmosphere -->
		<!-- Sky effect -->
		<T.Mesh
			scale={1.003}
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
		</T.Mesh>

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

<!-- Camera -->
<T.PerspectiveCamera position={[0, 0, 15]} zoom={1} fov={30} near={0.1} far={20000} makeDefault>
	<OrbitControls autoRotate={true} autoRotateSpeed={0} enableZoom={true} />
</T.PerspectiveCamera>

<!-- Ligh (Sun)-->
<T.DirectionalLight
	color={0xffffff}
	intensity={$darkmode ? 1 : 2}
	position={[0, 0, 100]}
	castShadow
/>

<!-- <SoftShadows focus={1} samples={20} size={20}/> -->

<!-- Ligh (ambient) -->
<!-- <T.AmbientLight intensity={0.1}/> -->

<!-- Stars (Old version) -->
<!-- <Stars count={5000} depth={290} radius={50} speed={0} fade={false}/> -->

