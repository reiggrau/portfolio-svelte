<script lang="ts">
	import * as THREE from 'three';
	import { T, useTask, useLoader } from '@threlte/core';
	import { useSuspense, useTexture } from '@threlte/extras';

	import { view } from '$lib/store';

	export let moonPosition: [number, number, number];

	// Textures
	import Device from 'svelte-device-info';

	const device = Device.isPhone ? 'mobile' : 'desktop';

	const moonTexture = useTexture(`/textures/${device}/moon_diffuse.jpg`, {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});
	const moonDisplacement = useLoader(THREE.TextureLoader).load(
		`/textures/${device}/moon_topography.jpg`
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
		<T.Mesh position={moonPosition} rotation.y={1.8}>
			<T.IcosahedronGeometry args={[2.1, 64]} />
			<T.MeshStandardMaterial
				color={0xffffff}
				map={$moonTexture}
				bumpMap={$moonDisplacement}
				bumpScale={2}
			/>
		</T.Mesh>
	</T.Group>
{/if}
