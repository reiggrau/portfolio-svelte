<script lang="ts">
	import { darkmode } from '$lib/store';
	import SkillCard from './SkillCard.svelte';
	import ArrowsDown from './ArrowsDown.svelte';

    import aws from '$lib/assets/aws.png';
    import css from '$lib/assets/css.png';
    import html from '$lib/assets/html.png';
    import javascript from '$lib/assets/javascript.png';
    import next from '$lib/assets/next.png';
    import node from '$lib/assets/node.png';
    import nuxt from '$lib/assets/nuxt.png';
    import react from '$lib/assets/react.png';
    import svelte from '$lib/assets/svelte.png';
    import tailwind from '$lib/assets/tailwind.png';
    import threejs from '$lib/assets/threejs.png';
    import threlte from '$lib/assets/threlte.png';
    import typescript from '$lib/assets/typescript.png';
    import vue from '$lib/assets/vue.png';
</script>

<div id="About" class="w-full h-screen flex flex-col justify-center text-center">
    <div class="max-w-screen px-[26%] flex flex-col items-center">
        <h1 class="text-3xl sm:text-4xl font-semibold text-gray-300 inline border-b-2 border-cyan-500">
            My skills
        </h1>
        <p class="mt-4 max-w-[700px] text-lg font-light text-gray-200">
			These are the languages, UI frameworks, and other skills I have experience with:
		</p>
        <div class='mt-8 text-white text-xl font-light flex gap-6 flex-wrap justify-center'>
            <SkillCard skillName={'HTML'} src={html}/>
            <SkillCard skillName={'CSS'} src={css}/>
            <SkillCard skillName={'JavaScript'} src={javascript}/>
            <SkillCard skillName={'TypeScript'} src={typescript}/>
            <SkillCard skillName={'Node.js'} src={node}/>
            <SkillCard skillName={'Svelte'} src={svelte}/>
            <SkillCard skillName={'React'} src={react}/>
            <SkillCard skillName={'Next'} src={next}/>
            <SkillCard skillName={'Vue.js'} src={vue}/>
            <SkillCard skillName={'Nuxt'} src={nuxt}/>
            <SkillCard skillName={'Tailwind'} src={tailwind}/>
            <SkillCard skillName={'three.js'} src={threejs}/>
            <SkillCard skillName={'Threlte'} src={threlte}/>
            <SkillCard skillName={'AWS'} src={aws}/>
        </div>
        <ArrowsDown/>
    </div>
</div>
