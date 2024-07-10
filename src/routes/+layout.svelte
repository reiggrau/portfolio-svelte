<script lang="ts">
	import '../app.css';
	import NavBar from '$lib/components/NavBar.svelte';
	import SocialsIcons from '$lib/components/SocialsIcons.svelte';
	import Footer from '$lib/components/Footer.svelte';
</script>

<head>
	<title>Welcome - ReigGrau</title>
</head>

<div id="layout-main">
	<!-- Top navbar -->
	<NavBar />

	<!-- Side social icons -->
	<SocialsIcons />

	<!-- Content -->
	<slot />

	<!-- Footer -->
	<Footer />
</div>
