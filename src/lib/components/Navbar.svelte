<script lang='ts'>
  import { page } from '$app/stores';
  import { Navbar, NavBrand, NavLi, NavUl, NavHamburger } from 'flowbite-svelte';
  $: activeUrl = $page.url.pathname;
</script>

<nav id='Navbar' class='font-long w-screen h-24 shadow-lg absolute flex justify-between'>
    <Navbar class='bg-black bg-opacity-20'>
        <NavBrand href="/" class='text-center mx-12'>
            <!-- <img src="/images/flowbite-svelte-icon-logo.svg" class="mr-3 h-6 sm:h-9" alt="Flowbite Logo" /> -->
            <span class="text-3xl text-white font-bold whitespace-nowrap dark:text-white">Guillem Reig-Grau</span>
        </NavBrand>
        <NavHamburger />
        <NavUl class='mx-6'>
            <NavLi href="/" class='text-3xl text-white font-thin hover:text-shadow shadow-white'>Home</NavLi>
            <NavLi href="/" class='text-3xl text-white font-thin hover:text-shadow shadow-white'>About</NavLi>
            <NavLi href="/" class='text-3xl text-white font-thin'>Skills</NavLi>
            <NavLi href="/" class='text-3xl text-white font-thin'>Projects</NavLi>
            <NavLi href="/" class='text-3xl text-white font-thin'>Contact</NavLi>
        </NavUl>
    </Navbar>
</nav>