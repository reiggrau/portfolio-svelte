<script lang="ts">
	import { darkmode } from '$lib/store';
	import ArrowsDown from './ArrowsDown.svelte';
</script>

<div id="About" class="w-full h-screen flex flex-col justify-center">
    <div class="max-w-[700px] mx-auto {!$darkmode ? 'mr-[55%] ml-[5%]' : 'ml-[55%] mr-[5%]'}">
        <h1 class="text-3xl sm:text-4xl font-semibold text-gray-300 inline border-b-2 border-cyan-500">
            A little about me
        </h1>
        <p class="mt-6 text-lg font-light text-gray-200 text-justify">
            I'm a JavaScript developer experienced in creating user friendly and visually appealing web applications using a variety of UI frameworks such as SvelteKit, React and Vue.
        </p>
        <p class="mt-4 text-lg font-light text-gray-200 text-justify">
            Before I became a developer, I was a computer-savvy architect who enjoyed modding apps and video games in my spare time, and some of the skills I acquired have proven very useful in the world of web development. Skills like project management, 3D modelling and the general ability to turn a client's ideas into a real product.
        </p>
        <p class="mt-4 text-lg font-light text-gray-200 text-justify">
            I am currently based in Barcelona after a few years studying and working in Berlin, which is now my second home.
        </p>
        <p class="mt-4 text-lg font-light text-gray-200 text-justify">
            I enjoy hiking, photography and reading about anything science or technology related, with my fascination with the universe being the source of the idea to create a portfolio site like this.
        </p>
        <ArrowsDown/>
    </div>
</div>
