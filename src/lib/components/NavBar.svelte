<script lang="ts">
	import { BarsSolid } from 'flowbite-svelte-icons';

	import { view } from '$lib/store';

	import DarkMode from './DarkMode.svelte';

	let mobileNav = false;
	let fadeIn = true;

	function toggleMovileNav(to: boolean) {
		fadeIn = to ? true : false;
		setTimeout(() => {
			mobileNav = to;
		}, 150);
	}
</script>

<div
	id="NavBar"
	class="fixed w-full h-20 md:h-16 shadow-lg bg-black bg-opacity-30 flex justify-between items-center text-white z-10"
>
	<!-- Dark mode button -->
	<DarkMode />

	<!-- Wide navigation bar -->
	<ul class="hidden md:flex flex gap-4 mr-12">
		<li class="text-glow" on:click={()=> view.set('earth')}>HOME</li>
		<li class="text-glow" on:click={()=> view.set('moon')}>ABOUT</li>
		<li class="text-glow">SKILLS</li>
		<li class="text-glow">PROJECTS</li>
		<li class="text-glow">CONTACT</li>
	</ul>

	<!-- Hamburger -->
	<button class="md:hidden p-2 mr-8" on:click={() => toggleMovileNav(true)}>
		<BarsSolid size="xl" />
	</button>
</div>

<!-- Mobile nav -->
{#if mobileNav}
	<div
		id="Nav-mobile"
		class="{fadeIn
			? 'animate-appear'
			: 'animate-disappear'} animate-appear absolute top-0 left-0 w-screen h-screen bg-black bg-opacity-80 text-white flex flex-col justify-center items-center"
		on:click={() => toggleMovileNav(false)}
	>
		<!-- Close button -->
		<!-- <div class='w-full flex justify-end p-6'>
            <button on:click={()=> sidebarEnabled = false}>
                <CloseSolid/>
            </button>
        </div> -->

		<!-- Nav -->
		<ul class="flex flex-col items-center gap-12 text-4xl p-12">
			<li class="font-light">HOME</li>
			<li class="font-light">ABOUT</li>
			<li class="font-light">SKILLS</li>
			<li class="font-light">PROJECTS</li>
			<li class="font-light">CONTACT</li>
		</ul>
	</div>
{/if}

<style lang="postcss">
	/* How to add text shadow in Tailwind: https://www.hyperui.dev/blog/text-shadow-with-tailwindcss */
	.text-glow {
		@apply cursor-pointer hover:text-shadow dark:shadow-blue-500 hover:-mt-1;
	}
</style>
