<!-- https://threlte.xyz/docs/learn/getting-started/your-first-scene -->

<script lang='ts'>
	import * as THREE from 'three';
	import { TextureLoader } from 'three';
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
	// Earth
	// const earthTexture = useLoader(TextureLoader).load('/textures/bodies/earth.jpg');
	// const earthNormal = useLoader(TextureLoader).load('/textures/bodies/earth_normal.tif');
	// const earthSpecular = useLoader(TextureLoader).load('/textures/bodies/earth_specular.tif');
	// const earthLights = useLoader(TextureLoader).load('/textures/bodies/earth_lights.jpg');
	// const earthClouds = useLoader(TextureLoader).load('/textures/bodies/earth_clouds.jpg');

	// Moon
	const moonTexture = useLoader(TextureLoader).load('/textures/bodies/moon_8k.jpg');
	const moonDisplacement = useLoader(TextureLoader).load('/textures/bodies/moon_displacement.jpg');

	// Halo

</script>

<!-- Earth -->
<T.Group>
	<!-- Terrain -->
	<!-- <T.Mesh
		scale={1}
		rotation.y={rotation / 20}
		rotation.x={23.4 * Math.PI / 180}
	>
		<T.SphereGeometry/>
		{#if $earthTexture}
			<T.MeshStandardMaterial map={$earthTexture} normalMap={$earthNormal} specularMap={$earthSpecular}  />
		{/if}
	</T.Mesh> -->

	<!-- City lights -->
	<!-- <T.Mesh
		scale={2}
	>
		<T.SphereGeometry/>
		{#if $textureLights}
			<T.MeshStandardMaterial map={$textureLights} blending={THREE.AdditiveBlending}/>
		{/if}
	</T.Mesh> -->

	<!-- Clouds -->
	<!-- <T.Mesh
		scale={1}
		rotation.y={rotation / 20}
		rotation.x={23.4 * Math.PI / 180}
	>
		<T.SphereGeometry/>
		{#if $earthClouds}
			<T.MeshStandardMaterial map={$earthClouds} bumpMap={$earthClouds} alphaMap={$earthClouds} blending={THREE.AdditiveBlending} transparent={true}/>
		{/if}
	</T.Mesh> -->

	<!-- Atmosphere effect -->
	<!-- Glow -->
	<!-- <T.Mesh
		scale={1.0}
		rotation.y={rotation / 20}
		rotation.x={23.4 * Math.PI / 180}
	>
		<T.SphereGeometry/>
		<T.ShaderMaterial
			{vertexShader}
			{fragmentShader}
			uniforms={{
				atmosphereColor: { value: new THREE.Color(0x38bdf8) }
			}}
			blending={THREE.AdditiveBlending}
		/>
	</T.Mesh> -->

	<!-- Halo -->
	<!-- <T.Mesh
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
	</T.Mesh> -->
</T.Group>



<!-- Moon -->
{#if $moonTexture}
<T.Mesh
	rotation.y={0}
	position={[0, 0, 0]}
>
	<T.IcosahedronGeometry args={[1, 64]}
	/>
	<T.MeshStandardMaterial color={0xffffff} map={$moonTexture} bumpMap={$moonDisplacement} bumpScale={5} displacementMap={$moonDisplacement} displacementScale={0.01}/>
</T.Mesh>
{/if}

<!-- Camera -->
<T.PerspectiveCamera position={[0, 0, 5]} zoom={1} fov={60} near={0.1} far={20000} makeDefault>
	<OrbitControls autoRotate={true} autoRotateSpeed={0.1} enableZoom={true} />
</T.PerspectiveCamera>

<!-- Ligh (Sun)-->
<T.DirectionalLight color={0xffffff} intensity={1.5} position={[0, 0, 10]}  />

<!-- Ligh (ambient) -->
<T.AmbientLight intensity={0.05}/>

<!-- Stars (New version) -->
<!-- <Stars count={5000} depth={60} radius={50} speed={0}/> -->
<!-- <Stars count={5000} depth={290} radius={50} speed={0} fade={false}/> -->

