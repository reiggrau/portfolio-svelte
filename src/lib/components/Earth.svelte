<script lang="ts">
	import * as THREE from 'three';
	import { T, useTask, useLoader, useThrelte } from '@threlte/core';
	import { useSuspense, useTexture } from '@threlte/extras';

	import { darkmode } from '$lib/store';

	import skyVS from '$lib/shaders/skyVS.glsl?raw';
	import skyFS from '$lib/shaders/skyFS.glsl?raw';
	import atmosphereVS from '$lib/shaders/atmosphereVS.glsl?raw';
	import atmosphereFS from '$lib/shaders/atmosphereFS.glsl?raw';

	export let position: [number, number, number];
	export let sunPosition: [number, number, number];

	const suspend = useSuspense();

	const { camera } = useThrelte();

	// Textures
	const earthTexture = suspend(
		useTexture('/textures/bodies/earth_16k_edited6_-50saturation.jpg', {
			transform: (texture) => {
				texture.anisotropy = 4;
				return texture;
			}
		})
	);
	const earthBump = useLoader(THREE.TextureLoader).load(
		'/textures/bodies/earth_topography_16k.jpg'
	);
	const earthSpecular = useLoader(THREE.TextureLoader).load(
		'/textures/bodies/earth_specular_inverted_gray.png'
	);
	const earthClouds = useTexture('/textures/bodies/earth_clouds_16k_brightness-30.jpg', {
		transform: (texture) => {
			texture.anisotropy = 4;
			texture.wrapS = THREE.RepeatWrapping;
			texture.wrapT = THREE.RepeatWrapping;
			return texture;
		}
	});
	const earthLights = useTexture('/textures/bodies/earth_lights.jpg', {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});

	// Atmosphere
	const color = new THREE.Color('#95D3F4');

	const atmospherePosition: [number, number, number] = [...position];
	atmospherePosition[0] += 0.2;

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
			uPower: { type: 'f', value: 0.65 }, // 0.65555555555
			usingDirectionalLighting: { type: 'i', value: true },
			directionalLightDirection: { type: 'v3', value: sunPosition }
		};

		const completeSkyUniforms = THREE.UniformsUtils.merge([
			THREE.UniformsLib['lights'],
			baseSkyUniforms
		]);

		console.log('cameraPosition :', $camera.position);
		return completeSkyUniforms;
	}

	// Animation
	let rotation = 0;

	useTask((delta) => {
		rotation += delta;
		if ($earthClouds) {
			$earthClouds.offset.set(0.4 - rotation / 5000, 0);
		}
		
		// Link camera view to shader uniform value
		if (skyUniforms.viewVector.value != $camera.position) {
			console.log('update!')
			skyUniforms.viewVector.value = $camera.position;
		}
	});

</script>

{#await earthTexture then}
	<T.Group {position} rotation.x={((23.4 * Math.PI) / 180) * 1} rotation.y={2.2 + rotation / 100}>
		<!-- Earth surface -->
		<T.Mesh scale={1}>
			<T.IcosahedronGeometry args={[7.9, 64]} />
			<T.MeshStandardMaterial
				color={0xffffff}
				map={$earthTexture}
				bumpMap={$earthBump}
				bumpScale={2}
				roughnessMap={$earthSpecular}
				roughness={0.99}
				displacementMap={$earthBump}
				displacementScale={0.01}
				lightMap={$earthClouds}
				lightMapIntensity={-1.2}
				emissive={0xffffff}
				emissiveMap={$earthLights}
				emissiveIntensity={$darkmode ? 0.7 : 0}
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
			<T.IcosahedronGeometry args={[7.9, 64]} />
			<T.MeshStandardMaterial
				color={'white'}
				alphaMap={$earthClouds}
				bumpMap={$earthClouds}
				bumpScale={0.1}
				transparent
				depthWrite={false}
			/>
		</T.Mesh>
	</T.Group>

	<!-- Atmosphere effect -->
	<T.Mesh scale={1.02} position={atmospherePosition}>
		<T.IcosahedronGeometry args={[7.9, 64]} />
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
	<T.Mesh scale={1.02} rotation.y={rotation} matrixAutoUpdate={false}>
		<T.IcosahedronGeometry args={[7.95, 64]} />
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
{/await}
