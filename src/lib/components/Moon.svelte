<script lang="ts">
	import * as THREE from 'three';
	import { T, useTask, useLoader } from '@threlte/core';
	import { useSuspense, useTexture } from '@threlte/extras';

	import { view } from '$lib/store';

	export let position: [number, number, number];

	// Textures
	const moonTexture = useTexture('/textures/bodies/moon_8k.jpg', {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});
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
 {#if $moonTexture}
	<T.Group rotation.y={rotation / 50000}>
		<T.Mesh {position} rotation.y={1.8}>
			<T.IcosahedronGeometry args={[2.1, 64]} />
			<T.MeshStandardMaterial
				color={0xffffff}
				map={$moonTexture}
				bumpMap={$moonDisplacement}
				bumpScale={$view === 'moon' ? 2 : 0}
			/>
		</T.Mesh>
	</T.Group>
{/if}
