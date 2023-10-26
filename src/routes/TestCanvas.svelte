<script lang="ts">
  import { onMount } from 'svelte';
  import * as THREE from 'three';
  import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
  import planeFragmentShader from '../shaders/fragment.glsl';
  import planeVertexShader from '../shaders/vertex.glsl';
let el: HTMLCanvasElement

function init() {
  const camera = new THREE.Camera();
  camera.position.z = 1;

  const scene = new THREE.Scene();

  const controls = new OrbitControls(camera, el)
  controls.enableDamping = true
  controls.enableZoom = false

  const directionalLight = new THREE.DirectionalLight(0x00fffc, 1);
  scene.add(directionalLight);

  directionalLight.position.set(0, 0, 2);
  const geometry = new THREE.PlaneGeometry(2, 2);

  const uniforms = {
    u_time: { type: "f", value: 1.0 },
    u_resolution: { type: "v2", value: new THREE.Vector2() },
    u_mouse: { type: "v2", value: new THREE.Vector2(10, 10) },
  };

  const material = new THREE.ShaderMaterial({
    uniforms: uniforms,
    vertexShader: planeVertexShader,
    fragmentShader: planeFragmentShader
  });

  var mesh = new THREE.Mesh(geometry, material);
  scene.add(mesh);

  const renderer = new THREE.WebGLRenderer({
    canvas: el
  }
  );
  renderer.setPixelRatio(window.devicePixelRatio);

  onWindowResize();
  window.addEventListener("resize", onWindowResize, false);

  document.onmousemove = function (e) {
    // uniforms.u_mouse.value.x = e.pageX;
    // uniforms.u_mouse.value.y = e.pageY;
  };
  function onWindowResize() {
    renderer.setSize(window.innerWidth, window.innerHeight);
    uniforms.u_resolution.value.x = renderer.domElement.width;
    uniforms.u_resolution.value.y = renderer.domElement.height;
  }

  function animate() {
    requestAnimationFrame(animate);
    render();
  }

  function render() {
    uniforms.u_time.value += 0.05 * (1 + uniforms.u_mouse.value.x / 200);
    renderer.render(scene, camera);
  }

  animate()
}

onMount(() => {
 init()
})


</script>

<canvas bind:this={el}></canvas>


