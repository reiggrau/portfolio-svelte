<script lang="ts">
	import { darkmode } from '$lib/store';
	import { Button, GradientButton } from 'flowbite-svelte';
	import ArrowsDown from './ArrowsDown.svelte';
	import SmallButton from './SmallButton.svelte';
</script>

<div id="Projects" class="w-full md:h-screen flex flex-col justify-center text-center">
	<div class="mx-auto">
		<h1 class="text-3xl sm:text-4xl font-light text-gray-300 inline border-b-2 border-cyan-500">
			My projects
		</h1>
		<p class="mt-4 text-lg font-light text-gray-200">These are some of my previous projects:</p>
		<div class="my-6 flex gap-8 justify-center flex-wrap">
			<!-- SBC -->
			<div
				class="w-[550px] h-[340px] bg-[url('/previews/sbc_preview.png')] bg-cover bg-center bg-black rounded shadow opacity-90"
			>
				<div
					class="pt-12 w-full h-full flex flex-col justify-center text-center text-white opacity-0 hover:opacity-100 bg-gray-950 bg-opacity-80 rounded"
				>
					<p class="text-4xl">Startup Business Cockpit</p>
					<p class="text-2xl text">Svelte - AWS</p>
					<div class="flex gap-4 justify-center">
						<SmallButton href="https://app.startup-business-cockpit.de/login" target="_blank"
							>Visit</SmallButton
						>
					</div>
				</div>
			</div>
			<!-- TRIBES -->
			<div
				class="w-[550px] h-[340px] bg-[url('/previews/tribes_preview.jpeg')] bg-cover bg-center bg-black rounded shadow opacity-90"
			>
				<div
					class="pt-12 w-full h-full flex flex-col justify-center text-center text-white opacity-0 hover:opacity-100 bg-gray-950 bg-opacity-80 rounded"
				>
					<p class="text-4xl">TRIBES</p>
					<p class="text-2xl text">React - PostgreSQL</p>
					<div class="flex gap-4 justify-center">
						<SmallButton href="https://tribes-the-game.onrender.com/" target="_blank"
							>Visit</SmallButton
						>
						<SmallButton href="https://github.com/reiggrau/tribes-frontend_react" target="_blank"
							>Code</SmallButton
						>
					</div>
				</div>
			</div>
			<!-- ImageBoard -->
			<div
				class="w-[550px] h-[340px] bg-[url('/previews/imageboard_preview.jpeg')] bg-cover bg-center bg-black rounded shadow opacity-90"
			>
				<div
					class="pt-12 w-full h-full flex flex-col justify-center text-center text-white opacity-0 hover:opacity-100 bg-gray-950 bg-opacity-80 rounded"
				>
					<p class="text-4xl">imageBoard</p>
					<p class="text-2xl text">VUE - PostgreSQL</p>
					<div class="flex gap-4 justify-center">
						<SmallButton
							href="https://www.linkedin.com/feed/update/urn:li:activity:7006326657682677760/"
							target="_blank">Visit</SmallButton
						>
						<SmallButton href="https://github.com/reiggrau/spiced_imageboard_vue" target="_blank"
							>Code</SmallButton
						>
					</div>
				</div>
			</div>
		</div>
		<ArrowsDown />
	</div>
</div>
