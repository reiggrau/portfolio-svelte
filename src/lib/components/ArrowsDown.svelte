<script>
	import Arrows from './Arrows.svelte';

	export let rotated = false;
</script>

<div id="ArrowsDown" class="flex justify-center {rotated ? 'rotate-180' : ''}">
	<div>
		<Arrows />
	</div>
</div>
