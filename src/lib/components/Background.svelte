<script lang="ts">
	import { Canvas } from '@threlte/core';
    import { Environment } from '@threlte/extras'
	import Scene from './Scene.svelte';

	let path = '/textures/background/';
	let files: string | string[] = 'starmap_16k_edited4.png';


	let useGround = true
    let scale = { x: 100, y: 100, z: 100 }
    let radius = 100
    let height = 5
</script>

<div id="Background" class="fixed w-screen h-screen">
	<Canvas
		rendererParameters={{
			antialias: true,
		}}
	>
	    <!-- Background -->
        <Environment
			{path}
            {files}
            isBackground={true}
        />
		<Scene/>
	</Canvas>
</div>
