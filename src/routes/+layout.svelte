<script lang="ts">
	import '../app.css';
	import NavBar from '$lib/components/NavBar.svelte';
	import SocialsIcons from '$lib/components/SocialsIcons.svelte';
	import Background from '$lib/components/Background.svelte';
</script>

<div class="h-screen w-screen">
	<NavBar />
	<SocialsIcons />
	<Background />

	<slot />
</div>
