<script lang="ts">
	import { onMount } from 'svelte';
	import { Canvas } from '@threlte/core';
	import { Environment } from '@threlte/extras';

	import { debug } from './state';
	import { view } from '$lib/store';

	import Scene from './Scene.svelte';
	import FadeIn from './FadeIn.svelte';
	import Home from './Home.svelte';
	import About from './About.svelte';
	import Skills from './Skills.svelte';
	import Projects from './Projects.svelte';

	const onScroll = () => {};
</script>

<svelte:window on:scroll={onScroll} />

<div id="Threlte" class="w-screen h-screen">
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
		<div class="fixed top-0 left-0 w-screen z-10">
			<FadeIn active={$view === 'earth'}>
				<Home />
			</FadeIn>
		</div>
		<div class="fixed w-screen">
			<FadeIn active={$view === 'moon'}>
				<About />
			</FadeIn>
		</div>
		<div class="fixed w-screen">
			<FadeIn active={$view === 'mars'}>
				<Skills />
			</FadeIn>
		</div>
		<div class="fixed w-screen">
			<!-- <FadeIn active={$view === 'venus'}>
				<Projects/>
			</FadeIn> -->
		</div>
	{/if}
</div>
