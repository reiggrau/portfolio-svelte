<script lang='ts'>
	import { VolumeUpOutline, VolumeUpSolid } from 'flowbite-svelte-icons';
    import { Tooltip } from 'flowbite-svelte';

    let sound = true;

    function toggleSound() {
        sound = !sound;
    }
</script>

<button id="SoundButton" class="text-gray" on:click={toggleSound}>
    {#if sound}
        <VolumeUpSolid class="h-7 w-7 md:h-5 md:w-5 animate-[spin_1s_ease-out_forwards]"/>
    {:else}
        <VolumeUpOutline class="h-7 w-7 md:h-5 md:w-5 animate-[spin_1s_ease-out_forwards]"/>
    {/if}
</button>
<Tooltip triggeredBy="#SoundButton">Toggle sound</Tooltip>
