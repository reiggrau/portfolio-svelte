<script lang="ts">
	import { debug } from '$lib/stores/threlte';

	import Home from './theater/Home.svelte';
	import About from './theater/About.svelte';
	import Skills from './theater/Skills.svelte';
	import Projects from './theater/Projects.svelte';
	import FadeIn from './FadeIn.svelte';
	import Contact from './theater/Contact.svelte';
</script>

<div id="Theater" class="overflow-y-auto overflow-x-hidden">
	<FadeIn active={!$debug}>
		<Home />
		<About />
		<Skills />
		<Projects />
		<Contact />
	</FadeIn>
</div>
