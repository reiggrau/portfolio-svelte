<!-- Source: https://codepen.io/nishchal-007/pen/vYZLrJB -->

<script>
	export let href;
	export let target;
	export let disabled = false;
</script>

<a {href} {target}>
	<button class="corner-button" {disabled}>
		<span>
			<slot />
		</span>
	</button>
</a>

<style>
	.outbutton {
		max-width: 80%;
		text-align: center;
	}

	.corner-button:before,
	.corner-button span:before,
	.corner-button:after,
	.corner-button span:after {
		display: block;
		content: '';
		width: 15px;
		height: 15px;
		position: absolute;
		text-align: center;
		justify-content: center;
		align-items: center;
	}
	.corner-button {
		display: inline-block;
		font-family: 'Roboto', sans-serif;
		font-size: 18px;
		letter-spacing: 5px;
		text-align: center;
		position: relative;
		min-width: 100px;
		min-height: 10px;
		margin: 20px;
		background: none;
		border: none;
		text-decoration: none;
		cursor: pointer;
		color: #25ccf7;
		border-radius: 10px;
		padding: 6px 10px;
		box-sizing: content-box;
		border: 2px solid transparent;
		text-align: center;
		line-height: 30px;
		transition: 0.75s ease;
	}
	.corner-button:before {
		top: -2px;
		left: -2px;
		border-top: 2px solid #0fbcf9;
		border-top-left-radius: 8px;
		border-left: 2px solid #0fbcf9;
		transition: 0.75s all;
	}
	.corner-button:after {
		top: -2px;
		right: -2px;
		border-top: 2px solid #0fbcf9;
		border-top-right-radius: 8px;
		border-right: 2px solid #0fbcf9;
		transition: 0.75s all;
	}
	.corner-button span {
		display: block;
		text-align: center;
		justify-content: center;
		align-items: center;
		margin-left: 8px;
	}
	.corner-button span:before {
		bottom: -2px;
		left: -2px;
		border-bottom: 2px solid #0fbcf9;
		border-bottom-left-radius: 8px;
		border-left: 2px solid #0fbcf9;
		transition: 0.75s all;
	}
	.corner-button span:after {
		bottom: -2px;
		right: -2px;
		border-bottom: 2px solid #0fbcf9;
		border-bottom-right-radius: 8px;
		border-right: 2px solid #0fbcf9;
		transition: 0.75s all;
	}
	.corner-button:hover {
		color: #ffffff;
		border-radius: 10px;
	}
	.corner-button:hover:before,
	.corner-button:hover:after {
		border-color: #1b9cfc;
		width: 100%;
		height: 100%;
		border-radius: 10px;
	}
	.corner-button:hover span:before,
	.corner-button:hover span:after {
		border-color: #1b9cfc;
		width: 100%;
		height: 100%;
		border-radius: 10px;
	}
	button:hover span::before,
	button:hover span::after {
		width: 50px;
		height: 50px;
		border-radius: 10px;
	}
</style>
