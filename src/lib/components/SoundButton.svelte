<script lang="ts">
	import { VolumeUpOutline, VolumeUpSolid } from 'flowbite-svelte-icons';
	import { Tooltip } from 'flowbite-svelte';

	let sound = true;

	function toggleSound() {
		sound = !sound;
	}

	let song = 'Cradle Of The Galaxy - By Andreas Waldetoft'
</script>

<button id="SoundButton" class="text-gray" on:click={toggleSound}>
	{#if sound}
		<VolumeUpSolid class="h-7 w-7 md:h-5 md:w-5" />
	{:else}
		<VolumeUpOutline class="h-7 w-7 md:h-5 md:w-5" />
	{/if}
</button>
<Tooltip triggeredBy="#SoundButton">Toggle sound</Tooltip>
<span class={sound ? 'animate-appearSlow' : 'animate-disappearSlow'}>Now playing: {song}</span>
