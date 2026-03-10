<script lang="ts">
	import * as THREE from 'three';
	import { T, useLoader } from '@threlte/core';
	import { useTexture } from '@threlte/extras';

	export let mercuryPosition: [number, number, number];

	// Textures
	const mercuryTexture = useTexture(`/textures/desktop/mercury_diffuse.jpg`, {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});
	const mercuryDisplacement = useLoader(THREE.TextureLoader).load(
		`/textures/desktop/mercury_topography.jpg`
	);
</script>

<!-- Mercury -->
{#if $mercuryTexture}
	<T.Group>
		<T.Mesh position={mercuryPosition} rotation.y={1.8}>
			<T.IcosahedronGeometry args={[2.1, 64]} />
			<T.MeshStandardMaterial
				color={0xffffff}
				map={$mercuryTexture}
				bumpMap={$mercuryDisplacement}
				bumpScale={2}
			/>
		</T.Mesh>
	</T.Group>
{/if}
