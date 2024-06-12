<!-- https://threlte.xyz/docs/learn/getting-started/your-first-scene -->

<script lang="ts">
	import * as THREE from 'three';
	import { T, useThrelte, useTask } from '@threlte/core';
	import { interactivity, OrbitControls, TrackballControls, Grid, Suspense, Text } from '@threlte/extras';

	import { onMount } from 'svelte'

	import { darkmode } from '$lib/store';

	import Earth from './Earth.svelte';
	import Moon from './Moon.svelte';

	import { debug } from './state';

	// Postprocess
	import Renderer from './Renderer.svelte';

	// Interactivity
	interactivity();

	// Sun position
	const sunPosition: [number, number, number] = [500, 0, 0];

	const { camera } = useThrelte();

	let fov = 30;
	let position: any = $darkmode ? [ -22, 0, 24 ] : [ 22, 0, 24 ];

	onMount(() => {
		console.log('window.innerWidth :', window.innerWidth);
		position = getCameraPosition(position, window.innerWidth);
	});

	function getCameraPosition(coordinates: [number, number, number], windowWidth: number) {
		// 1850 => 1420 => 1 => [ 22, 0, 24 ]
		// 430 => 0 => 2 => [ 11, 0, 44 ]

		const ratio = 2 - ((windowWidth - 430) / 1420);

		coordinates[0] = coordinates[0] / ratio;
		coordinates[2] = coordinates[2] * ratio;

		return coordinates;
	}

	// Navigation + debug
	let newPosition = [ ...position ];

	const onKeyDown = (e: KeyboardEvent) => {
		if (e.key === 'd') {
			console.log('debug:', !debug.current);
			debug.set(!debug.current);
		}

		if (e.key === 'ArrowDown') newPosition = [ 2.5, 0, -210 ];
		if (e.key === 'ArrowUp') newPosition = getCameraPosition([ 22, 0, 24 ], window.innerWidth);
	}

	// useTask((delta) => {
	// 	position = position.map((n, i) => n + (newPosition[i] / 60));
	// });

	function cameraGoTo(newPosition: [ number, number, number ]) {
		
	}

</script>

<svelte:window
	on:keydown={onKeyDown}
/>

<Suspense final>
	<Text
		position.z={-8}
		slot="fallback"
		text="Loading"
		fontSize={1}
		color="white"
		anchorX="50%"
		anchorY="50%"
		on:create={({ ref }) => {
			ref.lookAt(22, 0, 24)
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
	let:ref={camera}
>
	{#if $debug}
		<OrbitControls
			autoRotate={true}
			autoRotateSpeed={0.0}
			enableZoom={true}
			zoomSpeed={0.5}
			enableDamping
			on:change={()=>{console.log(camera.position)}}
		/>
	{/if}
	<TrackballControls
		enabled={false}
		staticMoving={false}
		zoomSpeed={0.5}
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

{#if $debug}
  	<Grid />
{/if}

