<svelte:head>
    <script>
		if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
			document.documentElement.classList.add('dark');
		} else {
			document.documentElement.classList.remove('dark');
		}
	</script>
</svelte:head>

<script lang='ts'>
    import { browser } from '$app/environment';
    import { darkmode } from '$lib/store';
    import { SunSolid, MoonSolid } from 'flowbite-svelte-icons';

    let systemDarkmode;
    let htmlClassList: any;

    if (browser) {
        systemDarkmode = window.matchMedia('(prefers-color-scheme: dark)');
        htmlClassList = window.document.documentElement.classList;

        systemDarkmode.matches ? darkmode.set(true) : darkmode.set(false);
    }

    function toggleDarkMode() {
        darkmode.set(!$darkmode);
        htmlClassList.toggle('dark');
    }
</script>

<button id='DarkMode' on:click={toggleDarkMode} class='text-gray p-2 ml-8'>
    {#if $darkmode}
        <MoonSolid/>
    {:else}
        <SunSolid/>
    {/if}
</button>