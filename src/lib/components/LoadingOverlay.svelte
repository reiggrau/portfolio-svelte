<script lang="ts">
	import { overlay, sound } from "$lib/store";

    let loadingDisappears = false;
    let overlayDisappears = false;

    function handleContinue() {
        sound.set(true);

        loadingDisappears = true;

        setTimeout(()=>{
            overlayDisappears = true;
        }, 500);

        setTimeout(()=>{
            overlay.set(false);
        }, 2000);
    }
</script>

{#if $overlay}
    <div id='LoadingOverlay' class='absolute w-screen h-screen top-0 left-0 z-50 bg-black flex flex-col justify-center items-center {overlayDisappears ? 'animate-disappearVerySlow' : ''}'>
        <span class='text-white text-4xl {loadingDisappears ? 'animate-disappearSlow' : 'animate-appearSlow'}'>ReigGrau presents</span>
        <button on:click={handleContinue}>Continue</button>
    </div>
{/if}