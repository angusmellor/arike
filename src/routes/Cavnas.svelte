<script>
	import { Canvas } from "@threlte/core";
	import Scene from "./Scene.svelte";
</script>

<div class="chrome">
  <Canvas>
    <Scene />
  </Canvas>
</div>

<style>
  .chrome {
    position: absolute;
    width: 100vw;
    height: 100vh;
    z-index: -10;
  }
</style>