<script lang="ts">
	import { view } from '$lib/store';
	import { debug } from './state';
	import { GlobeOutline, GlobeSolid } from 'flowbite-svelte-icons';
    import { Tooltip } from 'flowbite-svelte';

    import { Pane, ThemeUtils, List,type ListOptions } from 'svelte-tweakpane-ui';

	function toggleDebug() {
		debug.set(!$debug);
	}

    const options: ListOptions<string> = {
        Earth: 'earth',
        Moon: 'moon',
        Mars: 'mars',
        Venus: 'venus'
    };

    let selection: string = $view;

</script>

<button id="DebugButton" on:click={toggleDebug} class="text-gray">
	{#if $debug}
		<GlobeSolid
			class="h-7 w-7 md:h-5 md:w-5 animate-[spin_1s_ease-out_forwards]"
		/>
	{:else}
		<GlobeOutline class="h-7 w-7 md:h-5 md:w-5 animate-[spin_1s_ease-out_forwards]" />
	{/if}
</button>
<Tooltip triggeredBy="#DebugButton">Toggle free view</Tooltip>

{#if $debug}
<div class='mt-24'>
    <Pane
        position="draggable"
        title="Debug Menu"
        width={300}
    >
        <List bind:value={selection} label="View" {options} on:change={()=> view.set(selection)}/>
    </Pane>
</div>
{/if}