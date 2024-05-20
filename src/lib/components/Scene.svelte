<!-- https://threlte.xyz/docs/learn/getting-started/your-first-scene -->

<script>
	import { T, useTask } from '@threlte/core';
	import { interactivity, OrbitControls, Stars } from '@threlte/extras';
	import { spring } from 'svelte/motion';
	import { BufferAttribute, BufferGeometry } from 'three';

	// Interactivity
	interactivity();
	const scale = spring(1);

	// Animation
	let rotation = 0
	useTask((delta) => {
		rotation += delta
	})


</script>

<!-- Object -->
<!-- <T.Mesh
    rotation.y={rotation}
    scale={$scale}
    on:pointerenter={() => scale.set(1.5)}
    on:pointerleave={() => scale.set(1)}
>
    <T.BoxGeometry />
    <T.MeshStandardMaterial color="hotpink" />
</T.Mesh> -->

<!-- Camera -->
<T.PerspectiveCamera
  position={[10, 7, 10]}
  fov={60}
  near={1}
  far={20000}
  makeDefault
>
  <OrbitControls
    autoRotate={true}
    autoRotateSpeed={0.4}
    enableZoom={true}
  />
</T.PerspectiveCamera>

<!-- Lighting -->
<T.DirectionalLight position={[0, 10, 10]} />

<!-- Stars -->
<Stars 
	count={5000}
	depth={100}
	radius={50}
	speed={0}
/>