<script lang="ts">
  	import { onMount } from 'svelte';
	import { Canvas } from '@threlte/core';
	import { Environment } from '@threlte/extras';

	import { debug } from './state';
	import { view } from '$lib/store';

	
	import {
		_springScrollPos,
		mouseCoords,
		mouseCoordsSpring,
		scrollPos,
		springScrollPos
		} from './scrollPos';
		
	import Scene from './Scene.svelte';
	import FadeIn from './FadeIn.svelte';
	import Home from './Home.svelte';
	import About from './About.svelte';

	const onScroll = () => {
		// get normalized scroll position in document. 0 should equal top of page, 1
		// should equal 1 page height from top, 2 should equal 2 page heights from
		// top, etc. This allows easier addition of content to the bottom as opposed
		// to a normalized scroll position where 1 is the bottom of the page.
		const newScrollPos = Math.max(window.scrollY / window.innerHeight, 0);

		scrollPos.set(newScrollPos);

		_springScrollPos.set(newScrollPos);

		console.log('newScrollPos:', newScrollPos);
	}

	const onMouseMove = (e: MouseEvent) => {
		// get normalized mouse coords
		const x = e.clientX / window.innerWidth
		const y = e.clientY / window.innerHeight
		mouseCoords.set({ x, y })
		mouseCoordsSpring.set({ x, y })
	}

	onMount(() => {
		const newScrollPos = Math.max(window.scrollY / window.innerHeight, 0);

		scrollPos.set(newScrollPos);

		_springScrollPos.set(newScrollPos, {
			hard: true
		});
	})
</script>

<svelte:window
  	on:scroll={onScroll}
	on:mousemove={onMouseMove}
/>

<div id="Threlte" class="relative h-[500vh]">
	<div class="fixed left-0 top-0 h-[100lvh] w-full {$debug ? '' : '-z-10'}">
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

	<!-- Scene text -->
	{#if !$debug}
		<div class='fixed w-screen'>
			<FadeIn active={$view === 'earth'}>
				<Home />
			</FadeIn>
		</div>
		<div class='fixed w-screen'>
			<FadeIn active={$view === 'moon'}>
				<About />
			</FadeIn>
		</div>
	{/if}
</div>
