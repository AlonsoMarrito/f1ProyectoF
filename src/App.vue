<template>
  <header>
    <nav>
      <div class="divNav">
        <RouterLink to="/">Pilotos</RouterLink>
      </div>
      <div class="divNav">
        <RouterLink to="/grandesPremios">Grandes premios</RouterLink>
      </div>    
    </nav>
    <div id="player"></div>
  </header>
  <RouterView />
</template>

<script setup>
import { onMounted, ref } from 'vue'

// Variable reactiva para el reproductor
const player = ref(null)

onMounted(() => {
  // Cargar el script de la API de YouTube si no está cargado
  if (!window.YT) {
    const tag = document.createElement('script')
    tag.src = 'https://www.youtube.com/iframe_api'
    const firstScriptTag = document.getElementsByTagName('script')[0]
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)
  }

  // Inicializar el reproductor cuando la API de YouTube esté lista
  window.onYouTubeIframeAPIReady = function () {
    player.value = new YT.Player('player', {
      height: '390',
      width: '640',
      videoId: '8AYy-BcjRXg', // Cambia por el ID del video que quieras
      playerVars: {
        playsinline: 1,
      },
      events: {
        onReady: onPlayerReady,
        onStateChange: onPlayerStateChange
      }
    })
  }

  let done = false

  function onPlayerReady(event) {
    event.target.playVideo()
  }

  function onPlayerStateChange(event) {
    // Cuando el video empieza a reproducirse, se detiene después de 6 segundos
    if (event.data === YT.PlayerState.PLAYING && !done) {
      setTimeout(stopVideo, 6000)
      done = true
    }
  }

  function stopVideo() {
    player.value.stopVideo()
  }
})
</script>

<style>
header {
  width: 100%;
}

nav {
  display: flex;
  justify-content: space-between;
  padding: 10px;
}

.divNav {
  flex: 1;
  text-align: center;
}

#player {
  flex: 2;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-left: 20px;
}

.vistasVisibles {
  display: flex;
  width: 100%;
  justify-content: center;
  background: rgb(161, 175, 162);
  color: black;
  align-items: center;
  margin-top: 50px;
  height: 50px;
}
</style>
