<script lang="ts">
	import { overlay, sound } from "$lib/store";
	import { onMount } from "svelte";
	import ContinueButton from "./ContinueButton.svelte";

    let loadingDisappears = false;
    let overlayDisappears = false;

    let continueReady = false;

    onMount(()=>{
        setTimeout(()=>{
            continueReady = true;
        }, 200);
    })

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
        <div class='flex flex-col gap-4 {loadingDisappears ? 'animate-disappear' : 'animate-appear'}'>
            <h3 class='text-white text-2xl font-extralight'>
                <span class='font-normal text-3xl'>
                    ReigGrau 
                </span>
                presents:
            </h3>
            {#if continueReady}
                <!-- <button class='text-white font-light {continueReady ? 'animate-appearSlow' : 'opacity-0'}' on:click={handleContinue}> -->
                <button class='text-white font-light animate-appearSlow delay-1000' on:click={handleContinue}>
                    <ContinueButton />
                </button>
            {:else}
                <div class='px-[20px] py-[10px] h-[50px] flex justify-center'>
                    <span class='text-[#03e9f4] tracking-[4px] animate-appearVerySlow'>LOADING...</span>
                    <span class='absolute blur text-[#03e9f4] tracking-[4px] animate-appearVerySlow'>LOADING...</span>
                </div>
            {/if}
            <!-- <button class={continueReady ? 'animate-appearSlow' : 'opacity-0'} >Continue</button> -->
        </div>
        
    </div>
{/if}