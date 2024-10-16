<script lang="ts">
	import * as THREE from 'three';
	import { T, useTask, useLoader, useThrelte } from '@threlte/core';
	import { useTexture } from '@threlte/extras';

	import { darkmode, HD } from '$lib/store';
	import { debug } from '$lib/components/state';

	import skyVS from '$lib/shaders/skyVS.glsl?raw';
	import skyFS from '$lib/shaders/skyFS.glsl?raw';
	import atmosphereVS from '$lib/shaders/atmosphereVS.glsl?raw';
	import atmosphereFS from '$lib/shaders/atmosphereFS.glsl?raw';

	export let earthPosition: [number, number, number];
	export let sunPosition: [number, number, number];
	export let earthViewVector: { x: number; y: number; z: number };

	const { camera } = useThrelte();

	let viewVector = { x: 0, y: 0, z: 0 };

	// Textures
	import Device from 'svelte-device-info';

	$: textureRoure = $HD ? 'HD' : Device.isPhone ? 'mobile' : 'desktop';
	$: console.log('textureRoure :', textureRoure);

	$: earthTexture = useTexture(`/textures/${textureRoure}/earth_diffuse.jpg`, {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});
	$: earthBump = useLoader(THREE.TextureLoader).load(
		`/textures/${textureRoure}/earth_topography.jpg`
	);
	$: earthSpecular = useLoader(THREE.TextureLoader).load(
		`/textures/${textureRoure}/earth_specular.png`
	);
	$: earthClouds = useTexture(`/textures/${textureRoure}/earth_clouds.jpg`, {
		transform: (texture) => {
			texture.anisotropy = 4;
			texture.wrapS = THREE.RepeatWrapping;
			texture.wrapT = THREE.RepeatWrapping;
			return texture;
		}
	});
	$: earthLights = useTexture(`/textures/${textureRoure}/earth_lights.jpg`, {
		transform: (texture) => {
			texture.anisotropy = 4;
			return texture;
		}
	});

	// Atmosphere
	const atmosphereColor = new THREE.Color('#95D3F4');

	const atmospherePosition: [number, number, number] = [...earthPosition];
	atmospherePosition[0] += 0.2;

	const atmosphereUniforms = {
		aperture: { type: 'f', value: 0.71 },
		scale: { type: 'f', value: 28.0 },
		color: { type: 'c', value: atmosphereColor },
		opacity: { type: 'f', value: 1.0 }
	};

	// Sky
	const skyUniforms = getSkyUniforms();

	function getSkyUniforms() {
		const baseSkyUniforms = {
			uColor: {
				type: 'v4',
				value: new THREE.Vector4(atmosphereColor.r, atmosphereColor.g, atmosphereColor.b, 0.1)
			},
			viewVector: { type: 'v3', value: earthViewVector },
			uTop: { type: 'f', value: 0.95 }, // 0.94
			uPower: { type: 'f', value: 0.9 }, // 0.65555555555
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
		rotation += delta * ($debug ? 0.5 : 1);
		if ($earthClouds) {
			$earthClouds.offset.set(0.4 - rotation / ($debug ? 15000 : 3000), 0);
		}

		// Link camera view to shader uniform value
		if (skyUniforms.viewVector.value != earthViewVector) {
			skyUniforms.viewVector.value = earthViewVector;
		}
	});
</script>

{#if $earthTexture && $earthClouds}
	<T.Group
		position={earthPosition}
		rotation.x={((23.4 * Math.PI) / 180) * 1}
		rotation.y={2.2 + rotation / 200}
	>
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
				lightMap={$earthClouds}
				lightMapIntensity={-2}
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
	<T.Mesh scale={1.001} position={earthPosition}>
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
{/if}
