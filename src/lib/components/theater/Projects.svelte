<script lang="ts">
	import { darkmode } from '$lib/store';
	import { Button, GradientButton } from 'flowbite-svelte';
	import ArrowsDown from '../ArrowsDown.svelte';
	import SmallButton from '../SmallButton.svelte';

	import { Carousel } from 'flowbite-svelte';
	import projects from './projects.json';

	let projectIndex = 0;
	$: project = projects[projectIndex];
	let index = 0;
</script>

<div id="Projects" class="w-full h-screen flex flex-col justify-center">
	<div class="{$darkmode ? 'w-[50%] mr-[40%] ml-[5%]' : 'ml-[40%] mr-[5%]'} flex flex-col items-center">
		<ArrowsDown rotated/>
		<h1 class="text-3xl sm:text-4xl font-light text-gray-300 inline border-b-2 border-cyan-500">
			My projects
		</h1>
		<div class="my-6 h-[650px] flex flex-col items-center gap-4 opacity-90">
			<h2 class='text-white text-3xl'>{project.name}</h2>
			<Carousel images={project.images} forward let:Indicators let:Controls bind:index class='w-[650px] h-[500px]'>
				<Controls />
				<Indicators />
			</Carousel>
			<div class='w-[550px] bg-gray-800 opacity-90 px-6 py-4 rounded mt-4 flex justify-center'>
				<p class="max-w-[500px] text-center text-white text-lg">
					{project.text[index]}
				</p>
			</div>
			<div class='flex gap-8'>
				<SmallButton href={project.demo} target="_blank"
					>Visit</SmallButton
				>
				{#if project.code}
					<SmallButton href={project.code} target="_blank"
						>Code</SmallButton
					>
				{/if}
			</div>
		</div>
		<ArrowsDown />
	</div>
</div>
