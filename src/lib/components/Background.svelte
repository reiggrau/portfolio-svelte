<script lang="ts">
	import { Canvas } from '@threlte/core';
	import Scene from './Scene.svelte';
</script>

<div id="Background" class="fixed w-screen h-screen">
	<Canvas>
		<Scene />
	</Canvas>
</div>
