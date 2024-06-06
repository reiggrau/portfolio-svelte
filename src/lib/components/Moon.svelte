<script lang="ts">
	import * as THREE from 'three';
	import { T, useTask, useLoader } from '@threlte/core';
	import { useSuspense, useTexture } from '@threlte/extras';

	export let position: [number, number, number];

	const suspend = useSuspense();

	// Textures
	const moonTexture = suspend(
		useTexture('/textures/bodies/moon_8k.jpg', {
			transform: (texture) => {
				texture.anisotropy = 4;
				return texture;
			}
		})
	);
	const moonDisplacement = useLoader(THREE.TextureLoader).load(
		'/textures/bodies/moon_displacement.jpg'
	);

	// Animation
	let rotation = 0;
	useTask((delta) => {
		rotation += delta;
	});
</script>

<!-- Moon -->
<T.Group rotation.y={rotation / 1000}>
	{#if $moonTexture}
		<T.Mesh {position} rotation.y={1.8}>
			<T.IcosahedronGeometry args={[2.1, 64]} />
			<T.MeshStandardMaterial
				color={0xffffff}
				map={$moonTexture}
				bumpMap={$moonDisplacement}
				bumpScale={5}
				displacementMap={$moonDisplacement}
				displacementScale={0.01}
			/>
		</T.Mesh>
	{/if}
</T.Group>
