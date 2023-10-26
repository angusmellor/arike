<script lang="ts">  
  import { onMount } from 'svelte';
  import * as THREE from 'three';
  import blobFragmentShader from '../shaders/fragment.glsl';
  import blobVertexShader from '../shaders/vertex.glsl';

  let el: HTMLCanvasElement;

  function createScene(el: HTMLCanvasElement) {

    const scene = new THREE.Scene();

    const camera = new THREE.Camera();
    camera.position.z = 1
    scene.add(camera)
    
    // const controls = new OrbitControls(camera, el)
    // controls.enableDamping = true
    // controls.enableZoom = false
    
    const uniforms = {
        u_time: { value: 1.0 },
        u_resolution: { value: new THREE.Vector2() },
        u_mouse: { value: new THREE.Vector2() }
      };

    // const geometry = new THREE.BoxGeometry(1, 1, 1);
    const geometry = new THREE.PlaneGeometry(2,2);
    const material = new THREE.ShaderMaterial({
      uniforms: uniforms,
      vertexShader: blobVertexShader,
      fragmentShader: blobFragmentShader,
    })
    const mesh = new THREE.Mesh(geometry, material)
    scene.add(mesh)


    //sizes
    const sizes = {
      width: window.innerWidth,
      height: window.innerHeight
    }
    
    const renderer = new THREE.WebGLRenderer({
      canvas: el
    })
    renderer.setSize(sizes.width, sizes.height)

    window.addEventListener('resize', () => {
      // Update sizes
      sizes.width = window.innerWidth
      sizes.height = window.innerHeight

      // Update camera
      camera.aspect = sizes.width / sizes.height
      camera.updateProjectionMatrix()

        // Update renderer
      renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
      renderer.setSize(sizes.width, sizes.height)
      uniforms.u_resolution.value.x = renderer.domElement.width;
      uniforms.u_resolution.value.y = renderer.domElement.height;      
    })


    window.addEventListener('dblclick', () => {
      
      const fullscreenElement = document.fullscreenElement 
      if (!fullscreenElement) {
        if (!fullscreenElement) {
          if(el.requestFullscreen) {
            el.requestFullscreen()
          }
        }
      } else {
        if(document.exitFullscreen) {
          document.exitFullscreen()
        }
      }
    })

    // const renderer = new THREE.WebGLRenderer({antialias: true, canvas: el});

    // const geometry = new THREE.SphereGeometry( 1, 32, 32 );
    // const material = new THREE.ShaderMaterial( {
    //   side: THREE.DoubleSide,
    //   uniforms: {
    //     time: {value: 0},
    //     resolution: { value: new THREE.Vector4()},
    //   },
    //   // vertexShader: vertex,
    //   fragmentShader: fragment
    // } );

  const clock = new THREE.Clock()

  const tick = () => {
    const elapsedTime = clock.getElapsedTime()

    uniforms.u_time.value = elapsedTime

    // controls.update()
    renderer.render(scene, camera)

    window.requestAnimationFrame(tick)
  }

    tick()
  }

  onMount(() => {
    createScene(el)
  });

</script>


<canvas bind:this={el}></canvas>    