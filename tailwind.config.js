/** @type {import('tailwindcss').Config} */
const plugin = require('tailwindcss/plugin');

module.exports = {
	content: [
		'./src/**/*.{html,js,svelte,ts}',
		'./node_modules/flowbite-svelte/**/*.{html,js,svelte,ts}'
	],
	theme: {
		fontFamily: {
			sans: ['Helvetica', 'Arial', 'sans-serif'],
			serif: ['ui-serif', 'Georgia'],
			mono: ['ui-monospace', 'SFMono-Regular'],
			long: ['Monument Valley', 'Arial', 'sans-serif']
		},
		extend: {
			colors: {
				// flowbite-svelte
				primary: {
					50: '#FFF5F2',
					100: '#FFF1EE',
					200: '#FFE4DE',
					300: '#FFD5CC',
					400: '#FFBCAD',
					500: '#FE795D',
					600: '#EF562F',
					700: '#EB4F27',
					800: '#CC4522',
					900: '#A5371B'
				}
			},
			textShadow: {
				sm: '0 1px 2px var(--tw-shadow-color)',
				DEFAULT: '1px 0px 10px var(--tw-shadow-color)',
				lg: '0 8px 16px var(--tw-shadow-color)'
			}
		}
	},
	plugins: [
		require('flowbite/plugin'),
		plugin(function ({ matchUtilities, theme }) {
			matchUtilities(
				{
					'text-shadow': (value) => ({
						textShadow: value
					})
				},
				{ values: theme('textShadow') }
			);
		})
	],
	darkMode: 'class'
};
