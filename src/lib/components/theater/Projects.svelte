<script lang="ts">
	import { darkmode } from '$lib/store';
	import { AngleRightSolid, AngleLeftSolid } from 'flowbite-svelte-icons';
	import ArrowsDown from '../ArrowsDown.svelte';
	import SmallButton from '../SmallButton.svelte';

	import { Carousel, Indicator } from 'flowbite-svelte';
	import projects from './projects.json';
	import Arrows from '../Arrows.svelte';

	let projectIndex = 0;
	let project = projects[projectIndex];

	let index = 0; // Picture index

	function changeProject(direction: boolean) {
		index = 0;
		if (direction) {
			projectIndex = projectIndex < projects.length - 1 ? projectIndex + 1 : 0
		} else {
			projectIndex = projectIndex < 1 ? projects.length - 1 : projectIndex - 1;
		}
		project = projects[projectIndex];
	}

	const onKeyDown = (e: KeyboardEvent) => {
		if (e.key === 'ArrowRight') {
			changeProject(true);
		} else if (e.key === 'ArrowLeft') {
			changeProject(false);
		}
	};
</script>

<svelte:window on:keydown={onKeyDown} />

<div id="Projects" class="w-full h-screen flex items-center">
	<div class="flex flex-col items-center {$darkmode ? 'ml-[5%] mr-[40%]' : 'ml-[50%] mr-[7%]'}">
		<ArrowsDown rotated/>
		<!-- <h1 class="text-3xl sm:text-3xl font-bold text-gray-300 inline border-b-2 border-cyan-500">
			My projects
		</h1> -->
		<div class='flex gap-6 items-center text-white'>
			<div>
				<button class='rotate-90  z-40' on:click={()=> changeProject(false)}>
					<Arrows />
				</button>
			</div>
			<div class="flex flex-col gap-2 items-center">
				<h2 class='text-white text-2xl'>{project.name}</h2>
				{#key project}
					<Carousel images={project.images} forward let:Indicators let:Controls bind:index class='w-[600px] min-h-[250px] max-h-[350px]'>
						<Controls let:ControlButton let:changeSlide>
							<ControlButton name="Previous" forward={false} class="text-black" on:click={()=>changeSlide(false)}/>
							<ControlButton name="Next" forward={true} class="text-black" on:click={()=>changeSlide(true)}/>
						</Controls>
						<Indicators let:selected>
							<Indicator class={selected ? 'bg-[#25ccf7]' : 'bg-gray-200'} size='sm'/>
						</Indicators>
					</Carousel>
				{/key}
				<div class='w-[550px] bg-gray-800 opacity-90 px-4 py-2 rounded mt-2 flex justify-center items-center h-24'>
					<p class="max-w-[500px] text-center text-white font-light">
						{project.text[index]}
					</p>
				</div>
				<div class='flex gap-8'>
					{#if project.demo}
						<a href={project.demo} target="_blank">
							<SmallButton>Visit</SmallButton>
						</a>
					{/if}
					{#if project.code}
						<a href={project.code} target="_blank">
							<SmallButton >Code</SmallButton>
						</a>
					{/if}
				</div>
			</div>
			<div>
				<button class='rotate-[270deg] z-40'  on:click={()=> changeProject(true)}>
					<Arrows />
				</button>
			</div>
		</div>
		<ArrowsDown />
	</div>
</div>
