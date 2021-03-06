stage = null
renderer = null
skeleton = null
perso = null
debug = false

default_data = [
  0.22972357273101807, -0.4395926594734192,   0,    # HEAD
  0.23327147960662842, -0.29323655366897583,  0,    # NECK
  0.15237367153167725, -0.2847425937652588,   0,    # LEFT_SHOULDER
  0.317313551902771,   -0.30206066370010376,  0,    # RIGHT_SHOULDER
  0.09324967861175537, -0.055348724126815796, 0,    # LEFT_ELBOW
  0.365278422832489,   -0.08148899674415588,  0,    # RIGHT_ELBOW
  0.06797856092453003,  0.16002964973449707,  0,    # LEFT_HAND
  0.38161230087280273,  0.14372903108596802,  0,    # RIGHT_HAND
  0.2365584373474121,  -0.14941272139549255,  0,    # TORSO
  0.18626320362091064, -0.002804279327392578, 0,    # LEFT_HIP
  0.29482144117355347, -0.006957024335861206, 0,    # RIGHT_HIP
  0.15062379837036133,  0.2996320128440857,   0,    # LEFT_KNEE
  0.3096275329589844,   0.2993088960647583,   0,    # RIGHT_KNEE
  0.0940011739730835,   0.5295442342758179,   0,    # LEFT_FOOT
  0.2737523317337036,   0.5397530794143677,   0,    # RIGHT_FOOT
]

setup = ->
  stage = new PIXI.Stage 0xFFFFFF
  renderer = PIXI.autoDetectRenderer window.innerWidth, window.innerHeight, null, false, true
  document.body.appendChild renderer.view

  skeleton = new Skeleton()
  skeleton.data = default_data
  skeleton.dataRatio = 640 / 480
  skeleton.resize()

  perso = new Perso()
  perso.setFromSkeleton skeleton
  stage.addChild perso.view

  windowResized()
  window.addEventListener('resize', windowResized)
  window.addEventListener('keydown', onKeyDown)

  skeleton.update 1
  perso.setFromSkeleton skeleton
  perso.update()

  requestAnimFrame animate

onKeyDown = (ev) ->
  if ev.keyCode == 83 # s
    debug = !debug
    perso.setDebug debug
    perso.update()

windowResized = (ev) ->
  sw = window.innerWidth*window.devicePixelRatio
  sh = window.innerHeight*window.devicePixelRatio
  renderer.resize sw,sh
  renderer.view.style.width = window.innerWidth + 'px'
  renderer.view.style.height = window.innerHeight + 'px'
  if skeleton
    skeleton.resize()
    skeleton.view.position.x = sw * 0.5
    skeleton.view.position.y = sh * 0.5
    perso.view.position.x = skeleton.view.position.x
    perso.view.position.y = skeleton.view.position.y

animate = ->
  requestAnimFrame animate
  renderer.render stage

setup()
