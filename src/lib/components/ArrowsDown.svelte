<!-- https://github.com/threlte/threlte/blob/3c5e37a223fe8f534fa533dbb074e671a8d6fa24/apps/docs/src/components/Hero/Intro/Intro.svelte -->

<script>
	import { view } from '$lib/store';

	export let rotated = false;

	function nextView() {
		switch ($view) {
			case 'earth':
				view.set('moon');
				break;
			case 'moon':
				view.set(rotated ? 'earth' : 'mars');
				break;
			case 'mars':
				view.set(rotated ? 'moon' : 'venus');
				break;
			case 'venus':
				break;
		}
	}
</script>

<div id="ArrowsDown" class="flex justify-center {rotated ? 'rotate-180' : ''}">
	<button on:click={nextView}>
		<svg
			xmlns="http://www.w3.org/2000/svg"
			width="32"
			height="32"
			class="pulse-1 -mb-[20px]"
			fill="#fff"
			viewBox="0 0 256 256"
		>
			<path
				d="M212.24,100.24l-80,80a6,6,0,0,1-8.48,0l-80-80a6,6,0,0,1,8.48-8.48L128,167.51l75.76-75.75a6,6,0,0,1,8.48,8.48Z"
			/>
		</svg>
		<svg
			xmlns="http://www.w3.org/2000/svg"
			width="32"
			height="32"
			class="pulse-2 -mb-[20px]"
			fill="#fff"
			viewBox="0 0 256 256"
		>
			<path
				d="M212.24,100.24l-80,80a6,6,0,0,1-8.48,0l-80-80a6,6,0,0,1,8.48-8.48L128,167.51l75.76-75.75a6,6,0,0,1,8.48,8.48Z"
			/>
		</svg>
		<svg
			xmlns="http://www.w3.org/2000/svg"
			width="32"
			height="32"
			class="pulse-3 -mb-[20px]"
			fill="#fff"
			viewBox="0 0 256 256"
		>
			<path
				d="M212.24,100.24l-80,80a6,6,0,0,1-8.48,0l-80-80a6,6,0,0,1,8.48-8.48L128,167.51l75.76-75.75a6,6,0,0,1,8.48,8.48Z"
			/>
		</svg>
	</button>
</div>

<style>
	@keyframes custom-pulse {
		50% {
			opacity: 0;
		}
	}
	.pulse-1 {
		animation: custom-pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
	}
	.pulse-2 {
		animation: custom-pulse 2s 0.3s cubic-bezier(0.4, 0, 0.6, 1) infinite;
	}
	.pulse-3 {
		animation: custom-pulse 2s 0.6s cubic-bezier(0.4, 0, 0.6, 1) infinite;
	}
</style>
