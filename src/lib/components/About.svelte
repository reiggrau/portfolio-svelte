<script lang="ts">
	import { darkmode } from '$lib/store';
	import ArrowsDown from './ArrowsDown.svelte';
</script>

<div id="About" class="w-full h-screen flex flex-col justify-center">
    <div class="max-w-[1000px] mx-auto {!$darkmode ? 'mr-[55%] ml-[5%]' : 'ml-[55%] mr-[5%]'}">
        <h1 class="text-3xl sm:text-4xl font-semibold text-gray-200 inline border-b-4 border-cyan-500">
            About
        </h1>
        <h1 class="mt-8 text-3xl sm:text-4xl font-semibold text-gray-300">
            A little about myself
        </h1>
        <p class="mt-4 max-w-[700px] text-lg font-light text-gray-200 text-justify">
            I'm a JavaScript developer experienced in creating user-friendly and visually appealing web applications on its entirety using a variety of UI framewroks like SvelteKit, React and Vue.
        </p>
        <p class="mt-4 max-w-[700px] text-lg font-light text-gray-200 text-justify">
            Before I became a developer I was a computer-savvy architect that enjoyed modding apps and videogames in his spare time, and some of the skills that I gained have turned out to be quite useful in the web-development world. Skills like project management, 3d modeling, and the overall ability to convert a client's ideas to a real product.
        </p>
        <p class="mt-4 max-w-[700px] text-lg font-light text-gray-200 text-justify">
            I am currently based in Barcelona after spending some years studying and working abroad in Berlin, my now second home.
        </p>
        <p class="mt-4 max-w-[700px] text-lg font-light text-gray-200 text-justify">
            I enjoy hiking, photography and reading about any science or technology-related topic, being my fascination with the universe the source of the idea to build a portfolio page like this one.
        </p>
        <ArrowsDown/>
    </div>
</div>
