<script lang="ts">
	import { Canvas } from '@threlte/core';
	import { Environment } from '@threlte/extras';
	import { debug } from '$lib/stores/threlte';

	import Scene from './threlte/Scene.svelte';
</script>

<div class="fixed w-full h-full {$debug ? 'z-20' : '-z-10'} overflow-hidden">
	<Canvas
		rendererParameters={{
			powerPreference: 'high-performance',
			antialias: false,
			stencil: false,
			depth: false
		}}
	>
		<!-- Background stars -->
		<Environment
			path={'/textures/background/'}
			files={'starmap_16k_edited4.png'}
			isBackground={true}
		/>

		<!-- 3D models + lights + camera -->
		<Scene />
	</Canvas>
</div>
