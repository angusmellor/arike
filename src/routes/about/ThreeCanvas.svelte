<script lang="ts">  
  import { onMount } from 'svelte';
  import * as THREE from 'three';
  import fragment from './shader/fragment.glsl';
  
  let el: HTMLCanvasElement;
  let time = 0;

  function createScene(el: HTMLCanvasElement) {

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

    const renderer = new THREE.WebGLRenderer({antialias: true, canvas: el});

    const geometry = new THREE.SphereGeometry( 1, 32, 32 );
    const material = new THREE.ShaderMaterial( {
      side: THREE.DoubleSide,
      uniforms: {
        time: {value: 0},
        resolution: { value: new THREE.Vector4()},
      },
      // vertexShader: vertex,
      fragmentShader: fragment
    } );

    const cube = new THREE.Mesh( geometry, material );
    scene.add( cube );

    camera.position.z = 5;

    function animate() {
      requestAnimationFrame( animate );
      time += 0.5;
      material.uniforms.time.value = time

      cube.rotation.x += 0.01;
      cube.rotation.y += 0.01;

      renderer.render( scene, camera );
    } 

    function resize() {
      renderer.setSize(window.innerWidth, window.innerHeight)
      camera.aspect = window.innerWidth / window.innerHeight
      camera.updateProjectionMatrix()
    }
    resize()
    animate(); 
  }

  onMount(() => {
    createScene(el)
  });

</script>


<canvas bind:this={el}></canvas>    