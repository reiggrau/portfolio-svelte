<!-- https://threlte.xyz/docs/learn/getting-started/your-first-scene -->

<script lang="ts">
	import { T, useThrelte } from '@threlte/core';
	import {
		interactivity,
		OrbitControls,
		TrackballControls,
		Suspense,
		Text
	} from '@threlte/extras';

	import { debug } from '../state';
	import { darkmode, view } from '$lib/store'; // 'earth' | 'moon' | 'mars'

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

	let cameraPosition: any = $darkmode ? [-22, 0, 24] : [22, 0, 24]; // Default
	let cameraTarget: any = $debug ? [0, 0, 0] : [0, 0, -16]; // Default

	// View vectors (required for atmosphere shaders)
	let earthViewVector = getViewVector(earthPosition);
	let marsViewVector = getViewVector(marsPosition);
	let venusViewVector = getViewVector(venusPosition);

	function getViewVector(bodyPosition: any) {
		const viewVector = {
			x: $camera.position.x - bodyPosition[0],
			y: $camera.position.y - bodyPosition[1],
			z: $camera.position.z - bodyPosition[2]
		};
		return viewVector;
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
		}else if (e.key === 'ArrowDown') {
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
	$: $darkmode || $view || $debug, viewChange();

	async function viewChange() {
		console.log('viewChange()', { $darkmode, $view, $debug });

		let endTargetPosition = cameraTarget; // Default is no change
		let endCameraPosition = cameraPosition; // Default is no change

		switch ($view) {
			case 'earth':
				endTargetPosition = $debug ? [ ...earthPosition ] : [0, 0, -16];
				endCameraPosition = $darkmode ? [-22, 0, 24] : [22, 0, 24];
				break;
			case 'moon':
				endTargetPosition = $debug ? [ ...moonPosition ] : [0, 0, 0];
				endCameraPosition = $darkmode ? [-3, 0, -210] : [2.5, 0, -210];
				break;
			case 'mars':
				endTargetPosition = $debug ? [ ...marsPosition ] : [0, 0, -10000];
				endCameraPosition = $darkmode ? [-7, 0, -10017] : [7, 0, -10017];
				break;
			case 'venus':
				endTargetPosition = $debug ? [ ...venusPosition ] : [0, 0, -20020];
				endCameraPosition = $darkmode ? [-15, 0, -19972] : [20, 0, -19975];
				break;
			case 'mercury':
				endTargetPosition = $debug ? [ ...mercuryPosition ] : [0, 0, -29995];
				endCameraPosition = $darkmode ? [-6, 0, -30008] : [6, 0, -30008];
				break;
		}

		if ($debug) {
			// OLD: Just update the positions - Only in debug mode
			cameraTarget = endTargetPosition;
			cameraPosition = endCameraPosition;
			setCameraPosition(endCameraPosition);
			updateViewVectors();
			//
		} else {
			// NEW: Smooth transition
			// setCameraAndTargetPositionSmooth(cameraTarget, endTargetPosition, cameraPosition, endCameraPosition);
	
			// OLD: Just update the positions - Only in debug mode
			cameraTarget = endTargetPosition;
			cameraPosition = endCameraPosition;
			setCameraPosition(endCameraPosition);
			updateViewVectors();
			//

			// cameraTarget = endTargetPosition;
			// cameraPosition = endCameraPosition;
			// setCameraPosition(endCameraPosition);
			// updateViewVectors();
		}
	}

	function setCameraPosition(position: [number, number, number]) {
		$camera.position.set(position[0], position[1], position[2]);
	}

	// function setCameraAndTargetPositionSmooth(startTargetPosition: [number, number, number], endTargetPosition: [number, number, number], startCameraPosition: [number, number, number], endCameraPosition: [number, number, number]) {
	// 	console.log('setCameraAndTargetPositionSmooth :', { startTargetPosition, endTargetPosition, startCameraPosition, endCameraPosition });
		
	// 	// 1. Use start and end positions to generate a vector for camera and target
	// 	// 1a. Target vector
	// 	// Moon to Mars > [0, 0, -200] to [0, 0, -10000] > [0, 0, -9800]
	// 	const targetVector = [ ...endTargetPosition ].map((x, i) => x - startTargetPosition[i]);
	// 	console.log('targetVector :', targetVector);

	// 	// Moon to Mars (light mode)> [2.5, 0, -210] to [7, 0, -10017] > [4.5, 0, -9807]
	// 	const cameraVector = [ ...endCameraPosition ].map((x, i) => x - startCameraPosition[i]);
	// 	console.log('cameraVector :', cameraVector );

	// 	// 2. Get the increments in 1/50 (50 frames per second)
	// 	const targetIncrement = targetVector.map(x => x / 50);
	// 	const cameraIncrement = cameraVector.map(x => x / 50);
	// 	console.log('increment vectors :', { targetIncrement, cameraIncrement });

	// 	// 3. Run a loop for each frame and update the positions with the increments
	// 	for (let f = 1; f <= 50; f++) {
	// 		setTimeout(()=>{
	// 			// Update target position
	// 			const currentTargetPosition = [ ...startTargetPosition ].map((x, i) => x + (targetIncrement[i] * f));
	// 			cameraTarget = [ ...currentTargetPosition ];

	// 			// Update camera position
	// 			const currentCameraPosition = [ ...startCameraPosition ].map((x, i) => x + (cameraIncrement[i] * f));
	// 			setCameraPosition([ ...currentCameraPosition ]);

	// 			updateViewVectors();

	// 			console.log('positions at frame :', { f, currentTargetPosition, currentCameraPosition });
	// 		} , 200 * f)
	// 	}
	// }

	function updateViewVectors() {
		// console.log('updateViewVectors() new $camera.position :', $camera.position );
		earthViewVector = getViewVector(earthPosition);
		marsViewVector = getViewVector(marsPosition);
		venusViewVector = getViewVector(venusPosition);
	}

	// Adapt camera position to window width
	// onMount(() => {
	// 	// console.log('window.innerWidth :', window.innerWidth);
	// 	position = getCameraPosition(position, window.innerWidth);
	// });

	// function getCameraPosition(coordinates: [number, number, number], windowWidth: number) {
	// 	// 1850 => 1420 => 1 => [ 22, 0, 24 ]
	// 	// 430 => 0 => 2 => [ 11, 0, 44 ]

	// 	const ratio = 2 - ((windowWidth - 430) / 1420);

	// 	coordinates[0] = coordinates[0] / ratio;
	// 	coordinates[2] = coordinates[2] * ratio;

	// 	return coordinates;
	// }
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

	<Mars {marsPosition} {sunPosition} {marsViewVector} />

	<Venus {venusPosition} {sunPosition} {venusViewVector} />

	<Mercury {mercuryPosition} />
</Suspense>

<!-- Camera -->
<T.PerspectiveCamera
	position={cameraPosition}
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
			target={cameraTarget}
			on:change={updateViewVectors}
		/>
	{/if}
	<TrackballControls target={cameraTarget} enabled={false} staticMoving={false} zoomSpeed={0.5} />
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
