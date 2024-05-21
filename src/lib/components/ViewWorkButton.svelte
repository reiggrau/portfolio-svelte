<!-- Thanks to Shawn @shawnrossouw: https://codepen.io/shawnrossouw -->
<!-- Source: https://codepen.io/shawnrossouw/pen/qeBxxb -->

<button
	class="btn mt-4 border border-neutral-400 dark:border-[#00d6fc4d] text-neutral-500 dark:text-[#00d6fc80] hover:text-neutral-800 dark:hover:text-[#00d6fc] hover:shadow dark:hover:shadow-[1px_1px_8px_#00d6fc4d] hover:text-shadow before:bg-neutral-700 dark:before:bg-[#00d6fc] after:bg-neutral-700 dark:after:bg-[#00d6fc]"
>
	<span
		class="line before:bg-neutral-700 dark:before:bg-[#00d6fc] after:bg-neutral-700 dark:after:bg-[#00d6fc]"
	></span>
	View my work
</button>

<style lang="postcss">
	@import url('https://fonts.googleapis.com/css?family=Roboto&display=swap');

	.btn {
		position: relative;
		/* border: solid 1px #00d6fc4d; */
		background: none;
		/* color: #00d6fc80; */
		font-family: 'Roboto', sans-serif;
		font-weight: normal;
		letter-spacing: 1.8px;
		width: 200px;
		height: 50px;
		padding: 0;
		outline: none;
	}
	.btn:hover {
		/* box-shadow: 1px 1px 8px #00d6fc4d; */
		/* color: #00d6fc; */
		/* text-shadow: 0 0 8px #00d6fc66; */
	}
	.btn:before {
		content: '';
		position: absolute;
		top: 0;
		left: 10%;
		width: 60px;
		height: 1px;
		transform: translateY(-1px);
		/* background: #00d6fc; */
		transition: all 0.25s ease;
	}
	.btn:hover::before {
		left: 0;
		width: 20px;
	}
	.btn:after {
		content: '';
		position: absolute;
		bottom: 0;
		right: 10%;
		width: 60px;
		height: 1px;
		transform: translateY(1px);
		/* background: rgba(0, 214, 252, 1); */
		transition: all 0.25s ease;
	}
	.btn:hover::after {
		right: 0;
		width: 20px;
	}
	.line:before {
		content: '';
		position: absolute;
		bottom: 30%;
		right: 0;
		width: 1px;
		height: 20px;
		transform: translateX(1px);
		/* background: rgba(0, 214, 252, 1); */
		transition: all 0.25s ease;
	}
	.btn:hover .line:before {
		bottom: 0%;
	}
	.line:after {
		content: '';
		position: absolute;
		top: 30%;
		left: 0;
		width: 1px;
		height: 20px;
		transform: translateX(-1px);
		/* background: rgba(0, 214, 252, 1); */
		transition: all 0.25s ease;
	}
	.btn:hover .line:after {
		top: 0;
	}
</style>
