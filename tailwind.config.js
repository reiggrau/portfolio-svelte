/** @type {import('tailwindcss').Config} */
const plugin = require('tailwindcss/plugin')

export default {
	content: [
		'./src/**/*.{html,js,svelte,ts}',
		'./node_modules/flowbite-svelte/**/*.{html,js,svelte,ts}'
	],
	plugins: [
		require('flowbite/plugin'),
		plugin(function ({ matchUtilities, theme }) {
			matchUtilities(
			  {
				'text-shadow': (value) => ({
				  textShadow: value,
				}),
			  },
			  { values: theme('textShadow') }
			)
		})
	],
	darkMode: 'class',
	theme: {
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
				sm: '1px 0 5px var(--tw-shadow-color)',
				DEFAULT: '1px 0 10px var(--tw-shadow-color)',
				lg: '1px 0 15px var(--tw-shadow-color)',
			},
			animation: {
				'appear': 'appear 0.1s linear forwards',
			},
			keyframes: {
				appear: {
					'0%': { opacity: 0 },
					'100%': { opacity: 100 },
				}
			}
		}
	}
};
