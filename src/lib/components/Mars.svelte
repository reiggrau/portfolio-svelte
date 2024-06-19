<script lang="ts">
	import * as THREE from 'three';
	import { T, useTask, useLoader, useThrelte } from '@threlte/core';
	import { useTexture } from '@threlte/extras';

	import { darkmode } from '$lib/store';

	import skyVS from '$lib/shaders/skyVS.glsl?raw';
	import skyFS from '$lib/shaders/skyFS.glsl?raw';
	import atmosphereVS from '$lib/shaders/atmosphereVS.glsl?raw';
	import atmosphereFS from '$lib/shaders/atmosphereFS.glsl?raw';

	export let position: [number, number, number];
	export let sunPosition: [number, number, number];

	const { camera } = useThrelte();

	// Textures
	// Source: https://www.solarsystemscope.com/textures/
	const marsTexture = useTexture('/textures/bodies/mars_8k.jpg', {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});
	// Source: https://www.deviantart.com/slimysomething
	const marsBump = useLoader(THREE.TextureLoader).load(
		'/textures/bodies/mars_topography_8k.png'
	);
	const marsClouds = useTexture('/textures/bodies/mars_clouds_2k.png', {
		transform: (texture) => {
			texture.anisotropy = 4;
			texture.wrapS = THREE.RepeatWrapping;
			texture.wrapT = THREE.RepeatWrapping;
			return texture;
		}
	});

	// Atmosphere
	const color = new THREE.Color('#ad6242');

	const atmospherePosition: [number, number, number] = [...position];
	atmospherePosition[0] += 0.1;

	const atmosphereUniforms = {
		aperture: { type: 'f', value: 0.71 },
		scale: { type: 'f', value: 28.0 },
		color: { type: 'c', value: color },
		opacity: { type: 'f', value: 1.0 }
	};

	// Sky
	const skyPosition: [number, number, number] = [...position];
	skyPosition[0] += 0;

	const vector = new THREE.Vector4(color.r, color.g, color.b, 0.1);

	let skyUniforms = getSkyUniforms();

	function getSkyUniforms() {

		const baseSkyUniforms = {
			uColor: { type: 'v4', value: vector },
			viewVector: { type: 'v3', value: $camera.position },
			uTop: { type: 'f', value: 0.94 }, // 0.94
			uPower: { type: 'f', value: 0.85 }, // 0.65555555555
			usingDirectionalLighting: { type: 'i', value: true },
			directionalLightDirection: { type: 'v3', value: sunPosition }
		};

		const completeSkyUniforms = THREE.UniformsUtils.merge([
			THREE.UniformsLib['lights'],
			baseSkyUniforms
		]);

		return completeSkyUniforms;
	}

	// Animation
	let rotation = 0;

	useTask((delta) => {
		rotation += delta;
		if ($marsClouds) {
			$marsClouds.offset.set(0.4 - rotation / 5000, 0);
		}
		
		// Link camera view to shader uniform value
		if (skyUniforms.viewVector.value != $camera.position) {
			skyUniforms.viewVector.value = $camera.position;
		}
	});

</script>

{#if $marsTexture && $marsClouds}
	<T.Group {position} rotation.x={((23.4 * Math.PI) / 180) * 1} rotation.y={2.2 + rotation / 100}>
		<!-- Mars surface -->
		<T.Mesh scale={1}>
			<T.IcosahedronGeometry args={[4, 64]} />
			<T.MeshStandardMaterial
				color={0xffffff}
				map={$marsTexture}
				bumpMap={$marsBump}
				bumpScale={2}
				roughness={0.99}
				displacementMap={$marsBump}
				displacementScale={0.01}
				lightMap={$marsClouds}
				lightMapIntensity={-0.5}
			/>
		</T.Mesh>

		<!-- City lights -->
		<!-- <T.Mesh
			scale={1}
		>
			<T.IcosahedronGeometry args={[7.9, 64]}/>
			<T.MeshStandardMaterial map={$earthLights} emissiveMap={$earthLights} emissiveIntensity={10} blending={THREE.AdditiveBlending}/>
		</T.Mesh> -->

		<!-- Clouds -->
		<T.Mesh scale={1.004}>
			<T.IcosahedronGeometry args={[4, 64]} />
			<T.MeshStandardMaterial
				color={'white'}
				alphaMap={$marsClouds}
				bumpMap={$marsClouds}
				bumpScale={0.1}
				transparent
				depthWrite={false}
			/>
		</T.Mesh>
	</T.Group>

	<!-- Atmosphere effect -->
	<T.Mesh scale={1.02} position={atmospherePosition}>
		<T.IcosahedronGeometry args={[4, 64]} />
		<T.ShaderMaterial
			vertexShader={atmosphereVS}
			fragmentShader={atmosphereFS}
			uniforms={atmosphereUniforms}
			transparent
			depthWrite={false}
			side={THREE.BackSide}
		/>
	</T.Mesh>

	<!-- Sky effect -->
	<T.Mesh scale={1.02} rotation.y={rotation} matrixAutoUpdate={false} position={[0, 5, 0]}>
		<T.IcosahedronGeometry args={[4.1, 64]}/>
		<T.ShaderMaterial
			vertexShader={skyVS}
			fragmentShader={skyFS}
			uniforms={skyUniforms}
			transparent
			blending={THREE.AdditiveBlending}
			depthWrite={false}
			depthTest
			needsUpdate
			lights
		/>
	</T.Mesh>
{/if}
