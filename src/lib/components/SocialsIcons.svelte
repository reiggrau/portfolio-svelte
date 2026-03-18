<script>
	import { LinkedinSolid, GithubSolid, NewspapperOutline } from 'flowbite-svelte-icons';
</script>

<!-- Icons -->
<div
	id="SocialsIcons"
	class="fixed hidden sm:block top-[40%] left-0 flex flex-col text-2xl text-white z-30 opacity-90"
>
	<!-- LinkedIn -->
	<a
		href="https://www.linkedin.com/in/reig-grau/"
		target="_blank"
		rel="noopener noreferrer"
		class="drawer bg-[#0e76a8] dark:bg-[#185a7a]"
	>
		<span class="w-28 text-center font-extralight">LinkedIn</span>
		<div class="w-10 h-10 flex justify-center items-center"><LinkedinSolid /></div>
	</a>
	<!-- Gitgub -->
	<a
		href="https://github.com/reiggrau"
		target="_blank"
		rel="noopener noreferrer"
		class="drawer bg-[#171515] dark:bg-[#121111]"
	>
		<span class="w-28 text-center font-extralight">Github</span>
		<div class="w-10 h-10 flex justify-center items-center"><GithubSolid /></div>
	</a>
	<!-- Resume -->
	<a
		href="https://www.dropbox.com/scl/fi/c15ko1pjvocoyf4sey7gu/CV-Guillem-Reig-Grau-2025-2-EN.pdf?rlkey=ai0ju3gy0r51h0meajz5jpesy&st=cq3fztse&dl=0"
		target="_blank"
		rel="noopener noreferrer"
		class="drawer bg-gray-500 dark:bg-gray-600"
	>
		<span class="w-28 text-center font-extralight">My CV</span>
		<div class="w-10 h-10 flex justify-center items-center"><NewspapperOutline /></div>
	</a>
</div>

<style lang="postcss">
	.drawer {
		@apply relative flex items-center -left-28 duration-300 shadow;
	}

	.drawer:hover {
		@apply left-0;
	}
</style>
