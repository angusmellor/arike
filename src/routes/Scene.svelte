<script lang="ts">
  import { T, useFrame, useThrelte } from '@threlte/core';
  import { OrbitControls } from '@threlte/extras';
  import { PlaneGeometry, Vector2 } from 'three';
  import fragmentShader from '../shaders/fragment.glsl?raw';
  import vertexShader from '../shaders/vertex.glsl?raw';

  const terrainSize = 30
  const geometry = new PlaneGeometry(terrainSize, terrainSize, 100, 100)
  
  const { size, invalidate } = useThrelte()
  
  let uniforms={
    u_time: { value: 0},
    u_resolution: { value: new Vector2($size.height, $size.width) },
    u_mouse: { value: new Vector2(10, 10) },
  }

  useFrame((_, delta) => {
    uniforms.u_time.value += delta
    invalidate()
  })

  // invalidate()

</script>

<T.PerspectiveCamera
  makeDefault
  fov={75}
  near={0.1}
  far={100}
  position={[1,1,100]}
  enableDamping
>
  <OrbitControls/>
</T.PerspectiveCamera>

<T.Mesh
  {geometry}
>
  <T.ShaderMaterial
    {fragmentShader}
    {vertexShader}
    {uniforms}
  >
</T.ShaderMaterial>

</T.Mesh>
