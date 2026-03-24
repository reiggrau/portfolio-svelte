<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { browser } from '$app/environment';

	import { tweened } from 'svelte/motion';
	import { cubicInOut } from 'svelte/easing';

	import { view } from '$lib/stores/app';
	import { debug } from '$lib/stores/threlte';

	import Home from './theater/Home.svelte';
	import About from './theater/About.svelte';
	import Skills from './theater/Skills.svelte';
	import Projects from './theater/Projects.svelte';
	import FadeIn from './FadeIn.svelte';
	import Contact from './theater/Contact.svelte';

	import { viewOrder, viewSections } from '../../types';
	import type { View } from '../../types';

	let isScrolling = false;
	let touchStartY = 0;
	const COOLDOWN = 1800;
	const SCROLL_DURATION = 1800;

	const scrollY = tweened(0, { duration: SCROLL_DURATION, easing: cubicInOut });

	// Keep the scroll container in sync with the tweened value
	$: {
		const container = browser ? document.getElementById('page-main') : null;
		if (container) container.scrollTop = $scrollY;
	}

	function navigateTo(nextView: View) {
		debug.set(false);
		view.set(nextView);

		const container = document.getElementById('page-main');
		const el = document.getElementById(viewSections[nextView]);
		if (container && el) {
			scrollY.set(el.offsetTop - container.offsetTop, { duration: SCROLL_DURATION });
		}
	}

	function navigate(direction: 1 | -1) {
		if (isScrolling) return;

		const currentViewIndex = viewOrder.indexOf($view);
		if (currentViewIndex === -1) return;

		const nextIndex = currentViewIndex + direction;
		if (nextIndex < 0 || nextIndex >= viewOrder.length) return;

		isScrolling = true;
		navigateTo(viewOrder[nextIndex]);
		setTimeout(() => (isScrolling = false), COOLDOWN);
	}

	function onWheel(e: WheelEvent) {
		if ($debug) return;
		e.preventDefault();
		navigate(e.deltaY > 0 ? 1 : -1);
	}

	function onTouchStart(e: TouchEvent) {
		touchStartY = e.touches[0].clientY;
	}

	function onTouchEnd(e: TouchEvent) {
		if ($debug) return;
		const delta = touchStartY - e.changedTouches[0].clientY;
		if (Math.abs(delta) > 50) navigate(delta > 0 ? 1 : -1);
	}

	function blockScroll(e: Event) {
		if (!$debug) e.preventDefault();
	}

	onMount(() => {
		document.addEventListener('wheel', onWheel, { passive: false });
		document.addEventListener('touchstart', onTouchStart);
		document.addEventListener('touchend', onTouchEnd);
		document.addEventListener('touchmove', blockScroll, { passive: false });
	});

	onDestroy(() => {
		if (!browser) return;
		document.removeEventListener('wheel', onWheel);
		document.removeEventListener('touchstart', onTouchStart);
		document.removeEventListener('touchend', onTouchEnd);
		document.removeEventListener('touchmove', blockScroll);
	});
</script>

<div
	id="Theater"
	class="overflow-x-hidden"
	class:overflow-hidden={!$debug}
	class:overflow-y-auto={$debug}
>
	<FadeIn active={!$debug}>
		<Home />
		<About />
		<Skills />
		<Projects />
		<Contact />
	</FadeIn>
</div>
