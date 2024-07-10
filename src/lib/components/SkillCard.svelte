<script lang="ts">
	export let src: any;
	export let skillName: string;
</script>

<div id="SkillCard">
	<div class="w-24 h-24 opacity-80 top-1/2 bottom-1/2">
		<img class="max-w-24 max-h-24" alt="JavaScript logo" {src} />
	</div>
	<h3>{skillName}</h3>
</div>
