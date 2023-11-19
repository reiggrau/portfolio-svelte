<script lang='ts'>
    import "../app.css";
    
	import NavBar from "$lib/components/NavBar.svelte";
</script>

<NavBar/>

<slot/>

<style lang="postcss">
    :global(html) {
        /* background-color: theme(colors.gray.950); */
    }
</style>