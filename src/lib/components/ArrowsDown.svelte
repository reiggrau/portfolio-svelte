<script>
	import { view } from '$lib/store';
	import Arrows from './Arrows.svelte';

	export let rotated = false;

	function nextView() {
		switch ($view) {
			case 'earth':
				view.set('moon');
				break;
			case 'moon':
				view.set(rotated ? 'earth' : 'mars');
				break;
			case 'mars':
				view.set(rotated ? 'moon' : 'venus');
				break;
			case 'venus':
				view.set(rotated ? 'mars' : 'earth');
				break;
		}
	}
</script>

<div id="ArrowsDown" class="flex justify-center {rotated ? 'rotate-180' : ''}">
	<button on:click={nextView}>
		<Arrows />
	</button>
</div>
