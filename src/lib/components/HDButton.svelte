<script lang="ts">
    import { Tooltip } from 'flowbite-svelte';
	import { onMount } from 'svelte';

    import { HD } from '$lib/store';
    import { debug } from '$lib/components/state';

    import Device from 'svelte-device-info';

    let device: 'mobile' | 'desktop';
    
    function toggleHD() {
        HD.set(!$HD);
	}
    
    onMount(()=>{
        device = Device.isPhone ? 'mobile' : 'desktop';
    })
</script>

{#if device === 'desktop' && $debug}
    <button id="HDButton" on:click={toggleHD} class="h-7 w-7 md:h-5 md:w-5 flex flex-col justify-center">
        <span class="text-3xl md:text-2xl font-bold italic font-mono {$HD ? '' : 'text-gray-400'}">HD</span>
        <span class="text-3xl md:text-2xl font-bold italic font-mono {$HD ? '' : 'text-gray-400'} absolute animate-[ping_1s_ease-out_forwards]">HD</span>
    </button>
    <Tooltip triggeredBy="#HDButton">Toggle HD mode</Tooltip>
{/if}