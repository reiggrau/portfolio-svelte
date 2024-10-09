<script lang="ts">
	import ViewWorkButton from '../ViewWorkButton.svelte';
	import ArrowsDown from '../ArrowsDown.svelte';

	import { darkmode } from '$lib/store';
</script>

<div id="Home" class="w-full h-screen flex flex-col justify-center">
	<div class="px-10 max-w-[1000px] mx-auto {$darkmode ? 'mr-[50%] ml-[10%]' : 'ml-[52%] mr-[5%]'}">
		<h3 class="text-lg font-light text-[#00d6fc] text-shadow shadow-cyan-200">Hi! My name is</h3>
		<h1 class="text-5xl sm:text-6xl font-semibold text-gray-200">Guillem Reig</h1>
		<h1 class="mt-2 text-4xl sm:text-4xl font-semibold text-gray-300">
			<span class="text-3xl">I'm a </span>Full Stack Web Developer
		</h1>
		<p class="mt-4 max-w-[700px] text-lg font-light text-gray-200">
			And I'd like us to get to know each other on this journey through the solar system.
		</p>
		<ViewWorkButton />
		<ArrowsDown />
	</div>
</div>
