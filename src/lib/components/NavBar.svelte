<script>
	import DarkMode from "./DarkMode.svelte";

    import { BarsSolid } from 'flowbite-svelte-icons'
</script>


<div id='NavBar' class='absolute w-full h-24 shadow-lg bg-black bg-opacity-25 flex justify-between items-center text-white'>
    <DarkMode/>
    <ul class='hidden md:flex gap-4 mr-12'>
        <li class='text-glow'>HOME</li>
        <li class='text-glow'>ABOUT</li>
        <li class='text-glow'>SKILLS</li>
        <li class='text-glow'>PROJECTS</li>
        <li class='text-glow'>CONTACT</li>
    </ul>
    <button class='md:hidden p-2 mr-8'>
        <BarsSolid/>
    </button>

</div>

<style lang="postcss">
    /* How to add text shadow in Tailwind: https://www.hyperui.dev/blog/text-shadow-with-tailwindcss */
    .text-glow { @apply hover:text-shadow shadow-white cursor-pointer hover:text-lg mx-2 hover:mx-0; }
</style>