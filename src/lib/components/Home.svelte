<script lang="ts">
	// import { darkmode } from '$lib/store';

	import ViewWorkButton from './ViewWorkButton.svelte';

	// $: src = $darkmode ? '/images/night.jpeg' : '/images/sunset.jpeg';
</script>

<!-- <div id='Welcome' class='w-full h-screen bg-white dark:bg-black' style='background-image: url({src})'> -->
<div id="Welcome" class="w-full h-screen flex flex-col justify-center bg-red-500">
	<div class="px-10 max-w-[1000px] mx-auto">
		<h3 class="text-lg text-sky-800 dark:text-sky-500">Hi! My name is</h3>
		<h1 class="text-5xl sm:text-7xl font-semibold text-gray-700 dark:text-gray-200">
			Guillem Reig
		</h1>
		<h1 class="mt-2 text-4xl sm:text-6xl font-semibold text-gray-600 dark:text-gray-300">
			I'm a Full Stack Web Developer
		</h1>
		<p class="mt-4 max-w-[700px] text-lg font-light text-gray-900 dark:text-gray-200">
			I am experienced in building secure and user friendly web applications in their entirety, from
			idea to product.
		</p>
		<!-- <button class='text-gray-900 dark:text-gray-100'>View work</button> -->
		<ViewWorkButton />
	</div>
</div>

<style lang="postcss">
	/* #Welcome {
        background-size: cover;
        background-position: center;
    } */
</style>
