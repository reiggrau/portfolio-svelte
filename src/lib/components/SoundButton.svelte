<script lang="ts">
	import { VolumeUpOutline, VolumeUpSolid } from 'flowbite-svelte-icons';
	import { Tooltip } from 'flowbite-svelte';

	import { overlay, sound } from '$lib/store';

	import music from '$lib/assets/media/cradle_of_the_galaxy.mp3';

	let song = {
		name: 'Cradle Of The Galaxy - By Andreas Waldetoft',
		src: music
	}

	function toggleSound() {
		sound.set(!$sound);
	}
</script>

<button id="SoundButton" class="text-gray" on:click={toggleSound}>
	{#if $sound}
		<VolumeUpSolid class="h-7 w-7 md:h-4 md:w-5" />
		<audio src={song.src} preload='auto' autoplay></audio>
	{:else}
		<VolumeUpOutline class="h-7 w-7 md:h-4 md:w-5" />
	{/if}
</button>
<Tooltip triggeredBy="#SoundButton">Toggle sound</Tooltip>
{#if !$overlay}
	<a class='link {$sound ? 'animate-appearSlow' : 'animate-disappearSlow pointer-events-none'} hover:underline font-light text-gray-200' href='https://open.spotify.com/track/4LOzzEEIxoAvHao0u9Qb1i?si=f07d5c1792fc46ea' target='_blank'>Now playing: {song.name}</a>
{/if}