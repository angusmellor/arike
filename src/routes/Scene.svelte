<script lang="ts">
  import { T, useFrame, useThrelte } from '@threlte/core';
  import { PlaneGeometry, Vector2 } from 'three';
  import fragmentShader from '../shaders/fragment.glsl?raw';
  import vertexShader from '../shaders/vertex.glsl?raw';

  const terrainSize = 30
  const geometry = new PlaneGeometry(terrainSize, terrainSize, 100, 100)
  
  const { size } = useThrelte()

  const resolution = new Vector2(1000, 1000);
  
  let time = 0;
  
  useFrame((_, delta) => {
    time += delta;
  })

</script>

<T.PerspectiveCamera
  makeDefault
  fov={75}
  near={0.1}
  far={100}
  position={[1,1,100]}
/>

<T.Mesh
  {geometry}
>
  <T.ShaderMaterial
    {fragmentShader}
    {vertexShader}
    uniforms={{
      u_time: {
        value: 0
      }
    }}
    uniforms.u_time.value={time}
  >
</T.ShaderMaterial>

</T.Mesh>
