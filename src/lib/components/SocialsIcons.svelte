<script>
	import {
		LinkedinSolid,
		GithubSolid,
		EnvelopeOutline,
		NewspapperOutline
	} from 'flowbite-svelte-icons';
</script>

<!-- Icons -->
<div
	id="SocialsIcons"
	class="hidden sm:block fixed top-[35%] left-0 flex flex-col text-2xl text-white"
>
	<!-- LinkedIn -->
	<a
		href="https://www.linkedin.com/in/reig-grau/"
		target="_blank"
		class="drawer bg-[#0e76a8] dark:bg-[#185a7a]"
	>
		<span class="w-32 text-center">LinkedIn</span>
		<div class="w-12 h-12 flex justify-center items-center"><LinkedinSolid size="lg" /></div>
	</a>
	<!-- Gitgub -->
	<a
		href="https://github.com/reiggrau"
		target="_blank"
		class="drawer bg-[#171515] dark:bg-[#121111]"
	>
		<span class="w-32 text-center">Github</span>
		<div class="w-12 h-12 flex justify-center items-center"><GithubSolid size="lg" /></div>
	</a>
	<!-- LinkedIn -->
	<a href="/" class="drawer bg-[#de5246] dark:bg-[#b63e34]">
		<span class="w-32 text-center">Email</span>
		<div class="w-12 h-12 flex justify-center items-center"><EnvelopeOutline size="lg" /></div>
	</a>
	<!-- Resume -->
	<a href="/" class="drawer bg-gray-500 dark:bg-gray-600">
		<span class="w-32 text-center">My CV</span>
		<div class="w-12 h-12 flex justify-center items-center"><NewspapperOutline size="lg" /></div>
	</a>
</div>

<style lang="postcss">
	.drawer {
		@apply relative flex items-center -left-32 hover:left-0 duration-300 shadow;
	}
</style>
