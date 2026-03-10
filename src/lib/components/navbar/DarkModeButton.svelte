<script lang="ts">
	import { browser } from '$app/environment';
	import { darkmode } from '$lib/stores/app';
	import { SunSolid, MoonSolid } from 'flowbite-svelte-icons';
	import { Tooltip } from 'flowbite-svelte';

	function toggleDarkMode() {
		darkmode.set(!$darkmode);
		if (browser) {
			document.documentElement.classList.toggle('dark');
		}
	}
</script>

<svelte:head>
	<script>
		if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
			document.documentElement.classList.add('dark');
		} else {
			document.documentElement.classList.remove('dark');
		}
	</script>
</svelte:head>

<button id="DarkModeButton" on:click={toggleDarkMode} class="text-gray">
	{#if $darkmode}
		<MoonSolid
			class="h-5 w-8 md:h-3 md:w-5 animate-[spin_1s_ease-out_forwards] hover:box-shadow shadow-white"
		/>
	{:else}
		<SunSolid class="h-6 w-7 md:h-4 md:w-5 animate-[spin_1s_ease-out_forwards]" />
	{/if}
</button>
<Tooltip triggeredBy="#DarkModeButton">Toggle dark mode</Tooltip>
