<script>
	import Canvas from './Cavnas.svelte';
	window.onSpotifyIframeApiReady = (IFrameAPI) => {
  const element = document.getElementById('embed-iframe');
	const callback = (EmbedController) => {};
  const options = {
      uri: 'spotify:track:0lqqBVjUNnSeUdx3TmSCma',
			width: "60%"
    };
  IFrameAPI.createController(element, options, callback);
};
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
	<script src="https://open.spotify.com/embed/iframe-api/v1" async></script>
</svelte:head>

<Canvas />

<h1>Padlock Arike</h1>

<div class="spotify" id="embed-iframe"></div>



<style>
	h1 {
		position: absolute;
		margin-left: 50px;
	}
</style>


