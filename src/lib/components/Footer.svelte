<script>
    import { Footer, FooterCopyright, FooterLinkGroup, FooterLink, FooterBrand, FooterIcon } from 'flowbite-svelte';
	import { GithubSolid } from 'flowbite-svelte-icons';
</script>

<Footer
	id="Footer"
	class="fixed bottom-0 w-full h-12 p-6 text-white font-light flex justify-between items-center z-30"
>
    <FooterCopyright href="https://www.linkedin.com/in/reig-grau/" target="_blank" by="ReigGrau™" year={2024} />
    <FooterIcon href="https://github.com/reiggrau/portfolio-svelte" target="_blank">
        <GithubSolid />
    </FooterIcon>
</Footer>
