<script lang="ts">
	import ViewWorkButton from './ViewWorkButton.svelte';

	import { darkmode } from '$lib/store';
</script>

<div id="Home" class="w-full h-screen flex flex-col justify-center">
	<div class="px-10 max-w-[1000px] mx-auto {$darkmode ? 'mr-[55%] ml-[5%]' : 'ml-[55%] mr-[5%]'}">
		<h3 class="text-lg text-sky-500">Hi! My name is</h3>
		<h1 class="text-5xl sm:text-7xl font-semibold text-gray-200">
			Guillem Reig
		</h1>
		<h1 class="mt-2 text-4xl sm:text-6xl font-semibold text-gray-300">
			I'm a Full Stack Web Developer
		</h1>
		<p class="mt-4 max-w-[700px] text-lg font-light text-gray-200">
			I am experienced in building secure and user friendly web applications in their entirety, from
			idea to product.
		</p>
		<ViewWorkButton />
	</div>
</div>
