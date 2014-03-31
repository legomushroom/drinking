class Main
  constructor:->
    @vars()
    @animate()
    @launch()
  vars:->
    @animate = @bind @animate, @
    @path = document.getElementById 'js-words-path'
    @realPath = document.getElementById 'words-path'
    @pathLength = @realPath.getTotalLength()
    @easing = document.getElementById 'js-custom-easing'
    @easingLength = @easing.getTotalLength()
    @text = @path.textContent
    @surpCnt = 3
  animate:->
    requestAnimationFrame(@animate)
    TWEEN.update()

  launch:->
    it = @
    offset = 0
    step = @pathLength/@surpCnt
    @tween = new TWEEN.Tween({ offset: 0, p:0 })
      .to({ offset: -step, p: 1 }, 5000)
      # .easing(TWEEN.Easing.Sinusoidal.InOut)
      .easing(TWEEN.Easing.Back.Out)
      .onUpdate(->
        es = it.getEasing @p
        currOffset = 415 + (@offset + offset)
        # currOffset *= es
        it.path.setAttribute 'startOffset', currOffset

        if @p is 1
          offset += @offset
      ).repeat(@surpCnt).delay(3000).start()

  getEasing:(process)->
    @easing.getPointAtLength(@easingLength-(process*@easingLength)).y/100

  bind:(func, context) ->
    wrapper = ->
      args = Array::slice.call(arguments)
      unshiftArgs = bindArgs.concat(args)
      func.apply context, unshiftArgs
    bindArgs = Array::slice.call(arguments, 2)
    wrapper

new Main