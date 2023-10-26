import * as THREE from 'three';

const scene = new THREE.Scene();

const camera = new THREE.Camera()
camera.position.z = 1
scene.add(camera)

const uniforms = {
  uTime: { value : 1.0 },
  uResolution : { value: new THREE.Vector2()}
}

const geometry = new THREE.SphereGeometry(3, 32, 32) 

const material = new THREE.ShaderMaterial({
  uniforms: uniforms,
  vertexShader: 
})
