<script lang="ts">
	import { BarsSolid } from 'flowbite-svelte-icons';

	import { debug } from '$lib/stores/threlte';

	import { view } from '$lib/stores/app';

	import DarkModeButton from './navbar/DarkModeButton.svelte';
	import DebugButton from './navbar/DebugButton.svelte';
	import HDButton from './HDButton.svelte';
	import SoundButton from './SoundButton.svelte';
	import type { SectionViews } from '../../types';

	let mobileNav = false;
	let fadeIn = true;

	const sectionViews: SectionViews = {
		Home: 'earth',
		About: 'moon',
		Skills: 'mars',
		Projects: 'venus',
		Contact: 'mercury'
	};

	function navigateTo(sectionId: keyof SectionViews) {
		debug.set(false);
		view.set(sectionViews[sectionId]);

		const el = document.getElementById(sectionId);
		if (el) el.scrollIntoView({ behavior: 'smooth' });
	}

	// Mobile nav
	function toggleMobileNav(to: boolean) {
		fadeIn = to ? true : false;
		setTimeout(() => {
			mobileNav = to;
		}, 150);
	}
</script>

<div
	id="NavBar"
	class="absolute top-0 text-sm font-light w-full h-20 md:h-14 pl-6 pr-12 shadow-lg bg-black bg-opacity-30 flex justify-between items-center text-white z-30"
>
	<!-- Settings buttons -->
	<div class="flex gap-6 items-center">
		<!-- Dark mode button -->
		<DarkModeButton />

		<!-- Free view button -->
		<DebugButton />

		<!-- HD button -->
		<HDButton />

		<!-- Sound button -->
		<SoundButton />
	</div>

	<!-- Wide navigation bar -->
	<nav class="hidden md:flex flex gap-4">
		<button class="text-glow" on:click={() => navigateTo('Home')}>HOME</button>
		<button class="text-glow" on:click={() => navigateTo('About')}>ABOUT</button>
		<button class="text-glow" on:click={() => navigateTo('Skills')}>SKILLS</button>
		<button class="text-glow" on:click={() => navigateTo('Projects')}>PROJECTS</button>
		<button class="text-glow" on:click={() => navigateTo('Contact')}>CONTACT</button>
	</nav>

	<!-- Hamburger -->
	<button class="md:hidden p-2 mr-8" on:click={() => toggleMobileNav(true)}>
		<BarsSolid size="lg" />
	</button>
</div>

<!-- Mobile nav -->
{#if mobileNav}
	<div
		id="Nav-mobile"
		class="{fadeIn
			? 'animate-appear'
			: 'animate-disappear'} animate-appear absolute top-0 left-0 w-screen h-screen bg-black bg-opacity-80 text-white flex flex-col justify-center items-center"
		role="button"
		tabindex="0"
		on:click={() => toggleMobileNav(false)}
		on:keydown={(e) => e.key === 'Enter' && toggleMobileNav(false)}
	>
		<!-- Nav -->
		<nav class="flex flex-col items-center gap-12 text-4xl p-12">
			<button
				class="font-light"
				on:click={() => {
					navigateTo('Home');
					toggleMobileNav(false);
				}}>HOME</button
			>
			<button
				class="font-light"
				on:click={() => {
					navigateTo('About');
					toggleMobileNav(false);
				}}>ABOUT</button
			>
			<button
				class="font-light"
				on:click={() => {
					navigateTo('Skills');
					toggleMobileNav(false);
				}}>SKILLS</button
			>
			<button
				class="font-light"
				on:click={() => {
					navigateTo('Projects');
					toggleMobileNav(false);
				}}>PROJECTS</button
			>
			<button
				class="font-light"
				on:click={() => {
					navigateTo('Contact');
					toggleMobileNav(false);
				}}>CONTACT</button
			>
		</nav>
	</div>
{/if}

<style lang="postcss">
	/* How to add text shadow in Tailwind: https://www.hyperui.dev/blog/text-shadow-with-tailwindcss */
	.text-glow {
		@apply cursor-pointer;
	}

	.text-glow:hover {
		@apply text-shadow -mt-1 shadow-white;
	}

	:global(.dark) .text-glow:hover {
		@apply shadow-blue-500;
	}
</style>
