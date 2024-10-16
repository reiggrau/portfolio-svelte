<script lang="ts">
	export let src: any;
	export let skillName: string;
</script>

<div id="SkillCard">
	<div class="w-20 h-20 opacity-80 top-1/2 bottom-1/2">
		<img class="max-w-20 max-h-20" alt="JavaScript logo" {src} />
	</div>
	<h3 class="text-sm">{skillName}</h3>
</div>
