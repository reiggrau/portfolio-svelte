<script lang="ts">
	import { Canvas } from '@threlte/core';
	import { Environment } from '@threlte/extras';

	import Scene from './Scene.svelte';
</script>

<div id="Threlte" class="relative h-[500vh]">
	<div class="fixed left-0 top-0 h-[100lvh] w-full">
		<Canvas
			rendererParameters={{
				powerPreference: 'high-performance',
				antialias: false,
				stencil: false,
				depth: false
			}}
		>
			<!-- Background stars -->
			<Environment path={'/textures/background/'} files={'starmap_16k_edited4.png'} isBackground={true} />
	
			<!-- 3D models + lights + camera -->
			<Scene />
		</Canvas>
	</div>
</div>
