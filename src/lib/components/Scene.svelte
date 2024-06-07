<!-- https://threlte.xyz/docs/learn/getting-started/your-first-scene -->

<script lang="ts">
	import * as THREE from 'three';
	import { T, useThrelte } from '@threlte/core';
	import { Suspense, Text, interactivity, OrbitControls, TrackballControls } from '@threlte/extras';

	import { onMount } from 'svelte'

	import { darkmode } from '$lib/store';

	import Earth from './Earth.svelte';
	import Moon from './Moon.svelte';

	// Postprocess
	import Renderer from './Renderer.svelte';

	// Interactivity
	interactivity();

	// Sun position
	const sunPosition: [number, number, number] = [500, 0, 0];

	const { camera } = useThrelte();

	let fov = 30;
	let position: any = $darkmode ? [ -23, 0, 25 ] : [ 22, 0, 24 ];

	onMount(() => {
		console.log(window.innerWidth);
		if (window.innerWidth < 640) {
			position = $darkmode ? [ -11, 0, 44 ] : [ 11, 0, 44 ];
		}
	});

	// function adjustCameraPosition(position) {

	// }
</script>

<Suspense final>
	<Text
		position.z={-8}
		slot="fallback"
		text="Loading..."
		fontSize={1}
		color="white"
		anchorX="50%"
		anchorY="50%"
		on:create={({ ref }) => {
			ref.lookAt(-40, 25, 40);
		}}
	/>

	<Earth position={[0, 0, 0]} {sunPosition} />

	<Moon position={[0, 0, -200]} />
</Suspense>

<!-- Camera -->
<T.PerspectiveCamera
	{position}
	{fov}
	zoom={1}
	near={0.1}
	far={20000}
	makeDefault
>
	<OrbitControls
		autoRotate={true}
		autoRotateSpeed={0}
		enableZoom={true}
		zoomSpeed={0.25}
		enableDamping
		on:change={()=>{console.log($camera.position)}}
	/>
	<TrackballControls
		staticMoving={false}
		zoomSpeed={0.1}
		target={[ 0, 0, -16]}
	/>
</T.PerspectiveCamera>

<!-- Ligh (Sun)-->
<T.DirectionalLight color={0xe8f7ff} intensity={4} position={sunPosition} />

<!-- Sun -->
<T.Mesh scale={1} position={sunPosition}>
	<T.IcosahedronGeometry args={[4, 32]} />
	<T.MeshStandardMaterial color={0xffffff} emissive={0xffffff} emissiveIntensity={10} />
</T.Mesh>

<!-- Ligh (ambient) -->
<T.AmbientLight color={0x07215c} intensity={0.2} />

<!-- Stars (Old version) -->
<!-- <Stars count={5000} depth={290} radius={50} speed={0} fade={false}/> -->

<!-- Postprocess -->
<Renderer />
