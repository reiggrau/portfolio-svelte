<script lang="ts">
	import * as THREE from 'three';
	import { T, useTask, useLoader } from '@threlte/core';
	import { useTexture } from '@threlte/extras';
	import { HD } from '$lib/store';
    import { debug } from '$lib/components/state';

	export let moonPosition: [number, number, number];

	// Textures
	import Device from 'svelte-device-info';

	$: textureRoure = $HD ? 'HD' : Device.isPhone ? 'mobile' : 'desktop';

	$: moonTexture = useTexture(`/textures/${textureRoure}/moon_diffuse.jpg`, {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});
	$: moonDisplacement = useLoader(THREE.TextureLoader).load(
		`/textures/${textureRoure}/moon_topography.jpg`
	);

	// Animation
	let rotation = 0;
	useTask((delta) => {
		rotation += delta;
	});
</script>

<!-- Moon -->
{#if $moonTexture}
	<T.Group rotation.y={$debug ? 0 : (rotation / 50000)}>
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
