<script lang="ts">
	import { spring } from 'svelte/motion';

	export let active: boolean;

	let progress = spring(0, {
		stiffness: 0.04,
		damping: 1.0
	});

	$: if (active) {
		progress.set(1);
	} else {
		progress.set(0);
	}
</script>

<!-- <div class={progress === target ? 'animate-appearSlow' : 'animate-disappearSlow'}> -->
{#if $progress}
	<div class="reveal" style="--progress: {$progress};">
		<slot />
	</div>
{/if}

<style>
	.reveal {
		--enter: calc(var(--progress) * 200%);
		--leave: calc(var(--enter) - 100%);
		mask-position: center;
		-webkit-mask-position-x: center;
		-webkit-mask-position-y: center;
		mask-size: cover;
		mask-image: linear-gradient(90deg, #000 var(--leave), transparent var(--enter));
	}
</style>
