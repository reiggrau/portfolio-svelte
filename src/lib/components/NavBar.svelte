<script>
	import DarkMode from "./DarkMode.svelte";
    import { BarsSolid, CloseSolid, LinkedinSolid } from 'flowbite-svelte-icons'

    let sidebarEnabled = false;
</script>


<div id='NavBar' class='fixed w-full h-16 shadow-lg bg-black bg-opacity-25 flex justify-between items-center text-white'>
    <!-- Dark mode button -->
    <DarkMode/>

    <!-- Wide navigation bar -->
    <ul class='hidden md:flex flex gap-4 mr-12'>
        <li class='text-glow'>HOME</li>
        <li class='text-glow'>ABOUT</li>
        <li class='text-glow'>SKILLS</li>
        <li class='text-glow'>PROJECTS</li>
        <li class='text-glow'>CONTACT</li>
    </ul>

    <!-- Hamburger -->
    <button class='md:hidden p-2 mr-8' on:click={()=> sidebarEnabled = true}>
        <BarsSolid/>
    </button>
</div>

<!-- Sidebar -->
<div id='NavBar-sidebar' class='{sidebarEnabled ? '' : 'hidden'} fixed w-64 h-screen flex flex-col text-white bg-red-500'>
    <!-- Close button -->
    <div class='w-full flex justify-end p-6'>
        <button on:click={()=> sidebarEnabled = false}>
            <CloseSolid/>
        </button>
    </div>
    
    <!-- Nav -->
    <ul class='flex flex-col gap-8 text-2xl p-12'>
        <li class='text-glow'>HOME</li>
        <li class='text-glow'>ABOUT</li>
        <li class='text-glow'>SKILLS</li>
        <li class='text-glow'>PROJECTS</li>
        <li class='text-glow'>CONTACT</li>
    </ul>
</div>

<!-- Icons -->
<!-- <div id='NavBar-socials' class='fixed bg-green-4 text-white'>
    <LinkedinSolid/>
</div> -->

<style lang="postcss">
    /* How to add text shadow in Tailwind: https://www.hyperui.dev/blog/text-shadow-with-tailwindcss */
    .text-glow { @apply hover:text-shadow shadow-white cursor-pointer; }
</style>