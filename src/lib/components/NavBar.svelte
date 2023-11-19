<script>
	import DarkMode from "./DarkMode.svelte";

    import { BarsSolid } from 'flowbite-svelte-icons'
</script>


<div id='NavBar' class='absolute w-full h-24 shadow-lg bg-black bg-opacity-25 flex justify-between items-center text-white'>
    <DarkMode/>
    <ul class='hidden md:flex gap-4 mr-12'>
        <li class='hover:text-shadow shadow-white'>HOME</li>
        <li>ABOUT</li>
        <li>SKILLS</li>
        <li>PROJECTS</li>
        <li>CONTACT</li>
    </ul>
    <button class='md:hidden p-2 mr-8'>
        <BarsSolid/>
    </button>

</div>