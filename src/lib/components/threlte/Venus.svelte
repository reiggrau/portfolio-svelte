<script lang="ts">
	import * as THREE from 'three';
	import { T, useTask } from '@threlte/core';
	import { useTexture } from '@threlte/extras';

	import skyVS from '$lib/shaders/skyVS.glsl?raw';
	import skyFS from '$lib/shaders/skyFS.glsl?raw';
	import atmosphereVS from '$lib/shaders/atmosphereVS.glsl?raw';
	import atmosphereFS from '$lib/shaders/atmosphereFS.glsl?raw';

	export let venusPosition: [number, number, number];
	export let sunPosition: [number, number, number];
	export let venusViewVector: any;

	const venusTexture = useTexture(`/textures/desktop/venus_diffuse.jpg`, {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});
	const venusClouds = useTexture(`/textures/desktop/venus_clouds_2.webp`, {
		transform: (texture) => {
			texture.anisotropy = 4;
			texture.wrapS = THREE.RepeatWrapping;
			texture.wrapT = THREE.RepeatWrapping;
			return texture;
		}
	});

	// Atmosphere
	const color = new THREE.Color('#f8e2b0');

	const atmospherePosition: [number, number, number] = [...venusPosition];
	atmospherePosition[0] += 0.22;

	const atmosphereUniforms = {
		aperture: { type: 'f', value: 0.71 },
		scale: { type: 'f', value: 28.0 },
		color: { type: 'c', value: color },
		opacity: { type: 'f', value: 1.0 }
	};

	// Sky
	const vector = new THREE.Vector4(color.r, color.g, color.b, 0.1);

	let skyUniforms = getSkyUniforms();

	function getSkyUniforms() {
		const baseSkyUniforms = {
			uColor: { type: 'v4', value: vector },
			viewVector: { type: 'v3', value: venusViewVector },
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

		if ($venusClouds) {
			$venusClouds.offset.set(0.4 + rotation / 400, 0);
		}

		// Link camera view to shader uniform value
		if (skyUniforms.viewVector.value != venusViewVector) {
			skyUniforms.viewVector.value = venusViewVector;
		}
	});
</script>

{#if $venusTexture}
	<T.Group
		position={venusPosition}
		rotation.x={((2.64 * Math.PI) / 180) * 1}
		rotation.y={0 - rotation / 500}
	>
		<!-- Venus surface -->
		<T.Mesh scale={1}>
			<T.IcosahedronGeometry args={[7.5, 64]} />
			<T.MeshStandardMaterial color={0xffffff} map={$venusTexture} bumpScale={2} roughness={0.99} />
		</T.Mesh>

		<!-- Clouds -->
		<T.Mesh scale={1.004}>
			<T.IcosahedronGeometry args={[7.5, 64]} />
			<T.MeshStandardMaterial map={$venusClouds} depthWrite={false} opacity={0.95} transparent />
		</T.Mesh>
	</T.Group>

	<!-- Atmosphere effect -->
	<T.Mesh scale={1.015} position={atmospherePosition}>
		<T.IcosahedronGeometry args={[7.5, 64]} />
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
	<T.Mesh scale={1.001} position={venusPosition}>
		<T.IcosahedronGeometry args={[7.5, 64]} />
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
