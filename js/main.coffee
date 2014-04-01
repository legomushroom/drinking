class Main
  constructor:->
    @vars()
    @animate()
    @interval = setInterval @launch, 2*@duration
    @launch()
  vars:->
    @animate  = @bind @animate, @
    @launch   = @bind @launch, @
    @path       = document.getElementById 'js-words-path'
    @realPath   = document.getElementById 'words-path'
    @pathLength = @realPath.getTotalLength()
    @adamsApple = document.getElementById 'js-adams-apple'
    @adamsLeft  = document.getElementById 'js-adams-left'
    @adamsRight = document.getElementById 'js-adams-right'
    @text = @path.textContent
    @surpCnt    = 3
    @delay      = 3000
    @duration   = 5000
    @startOffset = 415
    @intervalCnt = 0
    @offset = @startOffset
  animate:->
    requestAnimationFrame(@animate)
    TWEEN.update()

  launch:->
    if ++@intervalCnt > @surpCnt then clearInterval(@interlval)
    it = @
    step = @pathLength/@surpCnt
    @tween1 = new TWEEN.Tween({ offset: it.offset, p:0 })
      .to({ offset: it.offset-step, p: 1 }, @duration)
      # .easing(TWEEN.Easing.Sinusoidal.InOut)
      .easing(TWEEN.Easing.Sinusoidal.Out)
      .onUpdate(->
        it.path.setAttribute 'startOffset',  @offset
        it.offset = @offset
      ).onComplete(->
        it.tween2 = new TWEEN.Tween({ offsetReverse: it.offset, p:0 })
          .to({ offsetReverse: it.offset+100, p: 1 }, it.duration)
          .easing(TWEEN.Easing.Elastic.Out)
          .onUpdate(-> 
            it.path.setAttribute 'startOffset', @offsetReverse
            it.offset = @offsetReverse
          ).start()
      ).onStart(->it.gulp())
      .start()

  gulp:->
    it = @
    @neck2 = new TWEEN.Tween({ y: -15, angle: 1, p:0 })
      .to({ y:0, angle: 0, p: 1 }, @duration/6)
      .easing(TWEEN.Easing.Back.Out)
      .onUpdate(->
        it.adamsApple.setAttribute  'transform', "translate(0, #{@y})"
      )
    @neck1 = new TWEEN.Tween({ y: 0, angle:0, p:0 })
      .to({ y:-15, angle:1, p: 1 }, @duration/8)
      .easing(TWEEN.Easing.Back.Out)
      .onUpdate(->
        it.adamsApple.setAttribute    'transform', "translate(0, #{@y})"
      ).chain(@neck2).delay(@duration-(@duration/10)).start()

  bind:(func, context) ->
    wrapper = ->
      args = Array::slice.call(arguments)
      unshiftArgs = bindArgs.concat(args)
      func.apply context, unshiftArgs
    bindArgs = Array::slice.call(arguments, 2)
    wrapper

new Main