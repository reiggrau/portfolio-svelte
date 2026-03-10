<script lang="ts">
	import * as THREE from 'three';
	import { T, useTask } from '@threlte/core';
	import { useTexture } from '@threlte/extras';

	import { HD } from '$lib/stores/app';
	import { debug } from '$lib/stores/threlte';

	export let moonPosition: [number, number, number];

	// Textures
	import Device from 'svelte-device-info';

	$: textureRoute = $HD ? 'HD' : Device.isPhone ? 'mobile' : 'desktop';

	$: moonTexture = useTexture(`/textures/${textureRoute}/moon_diffuse.jpg`, {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});
	$: moonDisplacement = useTexture(`/textures/${textureRoute}/moon_topography.jpg`);

	// Animation
	let rotation = 0;
	useTask((delta) => {
		rotation += delta;
	});
</script>

<!-- Moon -->
{#if $moonTexture}
	<T.Group rotation.y={$debug ? 0 : rotation / 50000}>
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
