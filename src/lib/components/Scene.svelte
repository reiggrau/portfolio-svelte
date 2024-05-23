<!-- https://threlte.xyz/docs/learn/getting-started/your-first-scene -->

<script lang='ts'>
	import * as THREE from 'three'
	import { TextureLoader } from 'three'
	import { T, useTask, useLoader } from '@threlte/core';
	import { interactivity, OrbitControls, Stars } from '@threlte/extras';
	import { spring } from 'svelte/motion';

	import { darkmode } from '$lib/store';

	import { uniforms, fs, vs } from '../../getFresnelMat';

	import vertexShader from '$lib/shaders/vertexShader.glsl?raw';
	import fragmentShader from '$lib/shaders/fragmentShader.glsl?raw';
	import atmosphereVS from '$lib/shaders/atmosphereVS.glsl?raw';
	import atmosphereFS from '$lib/shaders/atmosphereFS.glsl?raw';

	// Interactivity
	interactivity();
	const scale = spring(1);

	// Animation
	let rotation = 48;
	useTask((delta) => {
		rotation += delta;
	});

	// Textures
	// Source: Vecteezy.com
	const textureLights = useLoader(TextureLoader).load('/textures/bodies/earthlights.png');
	const textureMoon = useLoader(TextureLoader).load('/textures/bodies/moon.jpg');
	const textureEarth = useLoader(TextureLoader).load('/textures/bodies/earth.png');

	// Halo
</script>

<!-- Earth -->
<T.Group
>
	<!-- Terrain -->
	<!-- <T.Mesh
		scale={2}
	>
		<T.SphereGeometry/>
		{#if $textureEarth}
			<T.MeshStandardMaterial map={$textureEarth} bumpMap={$textureEarth} />
		{/if}
	</T.Mesh> -->

	<T.Mesh
		scale={1.0}
		rotation.y={rotation / 10}
		rotation.x={-23.4 * Math.PI / 180}
	>
		<T.SphereGeometry/>
		{#if $textureEarth}
			<T.ShaderMaterial
				{vertexShader}
				{fragmentShader}
				uniforms={{
					globeTexture: { value: $textureEarth },
					hasAtmosphere: { value: true },
					atmosphereColor: { value: new THREE.Color(0x38bdf8) }
				}}
			/>
		{/if}
	</T.Mesh>

	<!-- City lights -->
	<!-- <T.Mesh
		scale={2}
	>
		<T.SphereGeometry/>
		{#if $textureLights}
			<T.MeshStandardMaterial map={$textureLights} blending={THREE.AdditiveBlending}/>
		{/if}
	</T.Mesh> -->

	<!-- Atmosphere effect -->
	<T.Mesh
		scale={1.2}
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
	</T.Mesh>
</T.Group>



<!-- Moon -->
<T.Mesh
	rotation.y={0}
	scale={0.5}
	position={[0, 0, 8]}
>
	<T.SphereGeometry />
	<!-- {#if $textureMoon}
		<T.MeshStandardMaterial map={$textureMoon} bumpMap={$textureMoon} />
	{/if} -->
	{#if $textureMoon}
		<T.ShaderMaterial
			{vertexShader}
			{fragmentShader}
			uniforms={{
				globeTexture: {
					value: $textureMoon
				},
				hasAtmosphere: { value: false },
			}}
		/>
	{/if}
</T.Mesh>

<!-- Camera -->
<T.PerspectiveCamera position={[0, 0, 5]} fov={60} near={0.1} far={20000} makeDefault>
	<OrbitControls autoRotate={true} autoRotateSpeed={0.1} enableZoom={true} />
</T.PerspectiveCamera>

<!-- Ligh (Sun)-->
<T.DirectionalLight position={[0, 0, 10]} />

<!-- Ligh (ambient) -->
<T.AmbientLight intensity={0.05}/>

<!-- Stars (New version) -->
<!-- <Stars count={5000} depth={60} radius={50} speed={0}/> -->
<Stars count={5000} depth={290} radius={50} speed={0} fade={false}/>

