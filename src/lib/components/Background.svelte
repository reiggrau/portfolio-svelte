<script lang="ts">
	import { Canvas } from '@threlte/core';
	import { Environment } from '@threlte/extras';
	import Scene from './Scene.svelte';

	let path = '/textures/background/';
	let files: string | string[] = 'starmap_16k_edited4.png';
</script>

<div id="Background" class="fixed w-screen h-screen">
	<Canvas
		rendererParameters={{
			powerPreference: 'high-performance',
			antialias: false,
			stencil: false,
			depth: false
		}}
	>
		<Environment {path} {files} isBackground={true} />
		<Scene />
	</Canvas>
</div>
