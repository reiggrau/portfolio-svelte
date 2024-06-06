<!-- https://threlte.xyz/docs/learn/getting-started/your-first-scene -->

<script lang="ts">
	import { T, useThrelte } from '@threlte/core';
	import { Suspense, Text, interactivity, OrbitControls, TrackballControls } from '@threlte/extras';

	import { darkmode } from '$lib/store';

	import Earth from './Earth.svelte';
	import Moon from './Moon.svelte';

	// Postprocess
	import Renderer from './Renderer.svelte';

	// Interactivity
	interactivity();

	// Sun position
	const sunPosition: [number, number, number] = [500, 0, 0];

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
	position={$darkmode ? [-12, 2, 15] : [12, 2, 15]}
	zoom={1}
	fov={50}
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
	/>
	<TrackballControls staticMoving={false} zoomSpeed={0.25} />
</T.PerspectiveCamera>

<!-- Ligh (Sun)-->
<T.DirectionalLight color={0xe8f7ff} intensity={4} position={sunPosition} />

<!-- Sun -->
<T.Mesh scale={1} position={sunPosition}>
	<T.IcosahedronGeometry args={[1, 32]} />
	<T.MeshStandardMaterial color={0xffffff} emissive={0xffffff} emissiveIntensity={10} />
</T.Mesh>

<!-- Ligh (ambient) -->
<T.AmbientLight color={0x07215c} intensity={0.2} />

<!-- Stars (Old version) -->
<!-- <Stars count={5000} depth={290} radius={50} speed={0} fade={false}/> -->

<!-- Postprocess -->
<Renderer />
