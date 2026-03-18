<script lang="ts">
	import '../app.css';
	import NavBar from '$lib/components/NavBar.svelte';
	import SocialsIcons from '$lib/components/SocialsIcons.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import LoadingOverlay from '$lib/components/LoadingOverlay.svelte';
	import ThreeBackground from '$lib/components/ThreeBackground.svelte';
</script>

<head>
	<title>Welcome - ReigGrau</title>
</head>

<div id="layout-main" class="h-screen w-screen overflow-hidden flex flex-col justify-between">
	<LoadingOverlay />
	<NavBar />
	<SocialsIcons />
	<slot />
	<Footer />
	<ThreeBackground />
</div>

<style lang="postcss">
	#layout-main {
		@apply flex flex-col min-h-screen;
	}
</style>
