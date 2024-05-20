<script lang='ts'>
    import { Canvas } from '@threlte/core'
    import { Environment } from '@threlte/extras'
    import Scene from './Scene.svelte'

    import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
    import { EXRLoader } from 'three/addons/loaders/EXRLoader.js';

    let isBackground = true
    let path = '/textures/background/'
    let files: string | string[] = 'hiptyc_2020_4k.hdr'
    let useGround = true
    let scale = { x: 100, y: 100, z: 100 }
    let radius = 100
    let height = 5
</script>

<div id='Background' class='fixed w-screen h-screen -z-10'>
    <Canvas>
        <!-- Background -->
        <!-- <Environment
            {path}
            {files}
            {isBackground}
            groundProjection={useGround
            ? { radius, height, scale: [scale.x, scale.y, scale.z] }
            : undefined}
        /> -->
        <!-- Objects -->
        <Scene />
    </Canvas>
</div>