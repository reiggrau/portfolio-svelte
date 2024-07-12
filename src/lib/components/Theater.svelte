<script lang="ts">
	import { onMount } from 'svelte';
	import { Canvas } from '@threlte/core';
	import { Environment } from '@threlte/extras';

	import { debug } from './state';
	import { view } from '$lib/store';

	import Scene from './threlte/Scene.svelte';
	import Home from './theater/Home.svelte';
	import About from './theater/About.svelte';
	import Skills from './theater/Skills.svelte';
	import Projects from './theater/Projects.svelte';
	import FadeIn from './FadeIn.svelte';

	const onScroll = () => {};
</script>

<svelte:window on:scroll={onScroll} />

<div id="Theater" class="w-screen h-screen">
	<div class="fixed w-full h-full {$debug ? 'z-20' : ''}">
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

	<!-- Scene text -->
	{#if !$debug}
		<FadeIn active={$view === 'earth'}>
			<Home />
		</FadeIn>
		<FadeIn active={$view === 'moon'}>
			<About />
		</FadeIn>
		<FadeIn active={$view === 'mars'}>
			<Skills />
		</FadeIn>
		<FadeIn active={$view === 'venus'}>
			<Projects/>
		</FadeIn>
	{/if}
</div>
