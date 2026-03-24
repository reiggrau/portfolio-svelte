<script lang="ts">
	import { T, useThrelte } from '@threlte/core';
	import { interactivity, OrbitControls, TrackballControls, Suspense, Text } from '@threlte/extras';
	import { tweened } from 'svelte/motion';
	import { cubicInOut } from 'svelte/easing';

	import { debug } from '$lib/stores/threlte';
	import { loadingPhase, darkmode, view } from '$lib/stores/app'; // 'earth' | 'moon' | 'mars'

	import Earth from './Earth.svelte';
	import Moon from './Moon.svelte';
	import Mars from './Mars.svelte';
	import Venus from './Venus.svelte';

	import Renderer from './Renderer.svelte';
	import Mercury from './Mercury.svelte';

	interactivity();

	// Positions
	const sunPosition: [number, number, number] = [200000, 0, 0];

	const earthPosition: [number, number, number] = [0, 0, 0];
	const moonPosition: [number, number, number] = [0, 0, -200];
	const marsPosition: [number, number, number] = [0, 0, -10000];
	const venusPosition: [number, number, number] = [0, 0, -20000];
	const mercuryPosition: [number, number, number] = [0, 0, -30000];

	// Camera
	const { camera } = useThrelte();
	const TRANSITION_DURATION = 1200;

	type Vec3 = [number, number, number];

	const cameraPosition = tweened<Vec3>($darkmode ? [-22, 0, 24] : [22, 0, 24], {
		duration: TRANSITION_DURATION,
		easing: cubicInOut
	});
	const cameraTarget = tweened<Vec3>($debug ? [0, 0, 0] : [0, 0, -16], {
		duration: TRANSITION_DURATION,
		easing: cubicInOut
	});

	// Keep Three.js camera in sync with tweened values
	$: {
		$camera.position.set($cameraPosition[0], $cameraPosition[1], $cameraPosition[2]);
		earthViewVector = getViewVector(earthPosition);
		marsViewVector = getViewVector(marsPosition);
		venusViewVector = getViewVector(venusPosition);
	}

	// View vectors (required for atmosphere shaders)
	let earthViewVector = getViewVector(earthPosition);
	let marsViewVector = getViewVector(marsPosition);
	let venusViewVector = getViewVector(venusPosition);

	function getViewVector(bodyPosition: [number, number, number]) {
		const viewVector = {
			x: $camera.position.x - bodyPosition[0],
			y: $camera.position.y - bodyPosition[1],
			z: $camera.position.z - bodyPosition[2]
		};
		return viewVector;
	}

	function updateViewVectors() {
		earthViewVector = getViewVector(earthPosition);
		marsViewVector = getViewVector(marsPosition);
		venusViewVector = getViewVector(venusPosition);
	}

	// Navigation + debug
	const onKeyDown = (e: KeyboardEvent) => {
		if (e.key === 'd') {
			debug.set(!debug.current);
		} else if (e.key === '1') {
			view.set('earth');
		} else if (e.key === '2') {
			view.set('moon');
		} else if (e.key === '3') {
			view.set('mars');
		} else if (e.key === '4') {
			view.set('venus');
		} else if (e.key === '5') {
			view.set('mercury');
		} else if (e.key === 'ArrowDown') {
			switch ($view) {
				case 'earth':
					view.set('moon');
					break;
				case 'moon':
					view.set('mars');
					break;
				case 'mars':
					view.set('venus');
					break;
				case 'venus':
					view.set('mercury');
					break;
			}
		} else if (e.key === 'ArrowUp') {
			switch ($view) {
				case 'moon':
					view.set('earth');
					break;
				case 'mars':
					view.set('moon');
					break;
				case 'venus':
					view.set('mars');
					break;
				case 'mercury':
					view.set('venus');
					break;
			}
		}
	};

	// Trigger at view change
	$: ($darkmode || $view || $debug, viewChange());

	async function viewChange() {
		let endTargetPosition = $cameraTarget;
		let endCameraPosition = $cameraPosition;

		switch ($view) {
			case 'earth':
				endTargetPosition = $debug ? [...earthPosition] : [0, 0, -16];
				endCameraPosition = $darkmode ? [-22, 0, 24] : [22, 0, 24];
				break;
			case 'moon':
				endTargetPosition = $debug ? [...moonPosition] : [0, 0, 0];
				endCameraPosition = $darkmode ? [-3, 0, -210] : [2.5, 0, -210];
				break;
			case 'mars':
				endTargetPosition = $debug ? [...marsPosition] : [0, 0, -10000];
				endCameraPosition = $darkmode ? [-7, 0, -10016] : [7, 0, -10016];
				break;
			case 'venus':
				endTargetPosition = $debug ? [...venusPosition] : [0, 0, -20020];
				endCameraPosition = $darkmode ? [-15, 0, -19972] : [20, 0, -19975];
				break;
			case 'mercury':
				endTargetPosition = $debug ? [...mercuryPosition] : [0, 0, -29995];
				endCameraPosition = $darkmode ? [-6, 0, -30008] : [6, 0, -30008];
				break;
		}

		const opts = $debug ? { duration: 0 } : {};
		cameraTarget.set(endTargetPosition, opts);
		cameraPosition.set(endCameraPosition, opts);
	}
</script>

<svelte:window on:keydown={onKeyDown} />

<Suspense final>
	<Text
		position.z={-8}
		slot="fallback"
		text="Loading"
		fontSize={1}
		color="white"
		anchorX="50%"
		anchorY="50%"
		on:create={({ ref }) => {
			ref.lookAt(22, 0, 24);
		}}
	/>
	<Earth {earthPosition} {sunPosition} {earthViewVector} />
	<Moon {moonPosition} />
	{#if $loadingPhase === 'remaining'}
		<Mars {marsPosition} {sunPosition} {marsViewVector} />
		<Venus {venusPosition} {sunPosition} {venusViewVector} />
		<Mercury {mercuryPosition} />
	{/if}
</Suspense>

<!-- Camera -->
<T.PerspectiveCamera
	position={$cameraPosition}
	fov={30}
	zoom={1}
	near={0.1}
	far={2000000}
	makeDefault
>
	{#if $debug}
		<OrbitControls
			autoRotate={true}
			autoRotateSpeed={0.0}
			enableZoom={true}
			zoomSpeed={0.5}
			enableDamping
			target={$cameraTarget}
			on:change={updateViewVectors}
		/>
	{/if}
	<TrackballControls target={$cameraTarget} enabled={false} staticMoving={false} zoomSpeed={0.5} />
</T.PerspectiveCamera>

<!-- Ligh (Sun)-->
<T.DirectionalLight color={0xe8f7ff} intensity={4} position={sunPosition} />

<!-- Sun -->
<T.Mesh scale={1} position={sunPosition}>
	<T.IcosahedronGeometry args={[800, 32]} />
	<T.MeshStandardMaterial color={0xffffff} emissive={0xffffff} emissiveIntensity={10} />
</T.Mesh>

<!-- Ligh (ambient) -->
<T.AmbientLight color={0x07215c} intensity={0.3} />

<!-- Stars (Old version) -->
<!-- <Stars count={5000} depth={290} radius={50} speed={0} fade={false}/> -->

<!-- Postprocess -->
<Renderer />
