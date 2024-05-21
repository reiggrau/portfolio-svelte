<!-- https://threlte.xyz/docs/learn/getting-started/your-first-scene -->

<script lang='ts'>
	import { T, useTask } from '@threlte/core';
	import { AnimatedSpriteMaterial, interactivity, OrbitControls, Stars } from '@threlte/extras';
	import { spring } from 'svelte/motion';
	import { BufferAttribute, BufferGeometry } from 'three';
	import * as THREE from 'three';
	import { browser } from '$app/environment';

	import { darkmode } from '$lib/store';

	// Interactivity
	interactivity();
	const scale = spring(1);

	// Animation
	let rotation = 0;
	useTask((delta) => {
		rotation += delta;
	});
</script>

<!-- Earth -->
<T.Mesh
	rotation.y={rotation}
	scale={1}
>
	<T.SphereGeometry />
	<T.MeshStandardMaterial color="rgb(135, 206, 235)" />
</T.Mesh>

<!-- Moon -->
<T.Mesh
	rotation.y={rotation}
	scale={0.25}
	position={[0, 0, 5]}
>
	<T.SphereGeometry />
	<T.MeshStandardMaterial color="white" />
</T.Mesh>

<!-- Camera -->
<T.PerspectiveCamera position={[10, 7, 10]} fov={60} near={1} far={20000} makeDefault>
	<OrbitControls autoRotate={true} autoRotateSpeed={0.1} enableZoom={true} />
</T.PerspectiveCamera>

<!-- Ligh (Sun)-->
<T.DirectionalLight position={[0, 10, 10]} />

<!-- Ligh (ambient) -->
<T.AmbientLight intensity={0.05}/>

<!-- Stars (New version) -->
<Stars count={5000} depth={60} radius={50} speed={0} />

