<script>
	import InstagramLogo from "$lib/images/instagram.svg";
	import SpotifyLogo from "$lib/images/spotifyFilled.svg";
	import TikTokLogo from "$lib/images/tiktok.svg";
	import './styles.css';
</script>

<svelte:head>
	<link rel="stylesheet"
  	href="https://fonts.googleapis.com/css?family=Sometype+Mono">
</svelte:head>

<div class="app">
	<main>
		<slot />
	</main>

	<footer>
		<a href="https://open.spotify.com/artist/41RqiU6bgH8KubopKyBBK6">
			<img class="logo" src={SpotifyLogo} alt="Spotify" />	
		</a>
		<a href="https://www.instagram.com/padlockarike/">
			<img class="logo" src={InstagramLogo} alt="Instagram"/>
		</a>
		<a href="https://www.tiktok.com/@padlockarike">
			<img class="logo" src={TikTokLogo} alt="TikTok"/>
		</a>
	</footer>
</div>

<style>
	.app {
		min-height: 100vh;
		display: flex;
		flex-direction: column;
	}
	
	main {
		flex: 1;
	}

	footer {
		max-width: 100vw;
		background: #9d9d9d;
		height: fit-content;
		padding: 5px;
		display: flex;
		justify-content: center;
		gap: 15px;
	}

	.logo {
		height: 32px;
		width: 32px;
	}
</style>
