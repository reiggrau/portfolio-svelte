<!-- Source: https://codepen.io/nishchal-007/pen/vYZLrJB -->

<script lang='ts'>
	export let submit = false;
	export let buttonState: 'ready' | 'disabled' | 'success' | 'error' = 'ready';

	$: buttonColor = getButtonColor(buttonState);

	function getButtonColor(buttonState: string) {
		console.log('buttonState :', buttonState);
		switch (buttonState) {
			case 'disabled':
				return '#808080';
			case 'success':
				return '#00FF00';
			case 'error':
				return '#FF0000';
			default:
				return '#0fbcf9';
		}
	}
</script>

<button id="SmallButton" class="corner-button" style="--theme-color: {buttonColor}" disabled={buttonState === 'disabled'} type={submit ? 'submit' : 'button'}>
	<span>
		<slot />
	</span>
</button>

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
		margin: 10px;
		background: none;
		border: none;
		text-decoration: none;
		cursor: pointer;
		color: var(--theme-color);
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
		border-top: 2px solid var(--theme-color);
		border-top-left-radius: 8px;
		border-left: 2px solid var(--theme-color);
		transition: 0.75s all;
	}
	.corner-button:after {
		top: -2px;
		right: -2px;
		border-top: 2px solid var(--theme-color);
		border-top-right-radius: 8px;
		border-right: 2px solid var(--theme-color);
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
		border-bottom: 2px solid var(--theme-color);
		border-bottom-left-radius: 8px;
		border-left: 2px solid var(--theme-color);
		transition: 0.75s all;
	}
	.corner-button span:after {
		bottom: -2px;
		right: -2px;
		border-bottom: 2px solid var(--theme-color);
		border-bottom-right-radius: 8px;
		border-right: 2px solid var(--theme-color);
		transition: 0.75s all;
	}
	.corner-button:hover {
		color: #ffffff;
		border-radius: 10px;
	}
	.corner-button:hover:before,
	.corner-button:hover:after {
		border-color: var(--theme-color);
		width: 100%;
		height: 100%;
		border-radius: 10px;
	}
	.corner-button:hover span:before,
	.corner-button:hover span:after {
		border-color: var(--theme-color);
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
