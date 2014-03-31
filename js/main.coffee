class Main
  constructor:->
    @vars()
    @animate()
    @launch()
  vars:->
    @animate = @bind @animate, @
    @path       = document.getElementById 'js-words-path'
    @realPath   = document.getElementById 'words-path'
    @pathLength = @realPath.getTotalLength()
    @easing     = document.getElementById 'js-custom-easing'
    @easingLength = @easing.getTotalLength()
    @adamsApple = document.getElementById 'js-adams-apple'
    @adamsLeft  = document.getElementById 'js-adams-left'
    @adamsRight = document.getElementById 'js-adams-right'
    @text = @path.textContent
    @surpCnt    = 2
    @delay      = 3000
    @duration   = 5000
  animate:->
    requestAnimationFrame(@animate)
    TWEEN.update()

  launch:->
    it = @
    offset = 0
    step = @pathLength/@surpCnt
    @tween = new TWEEN.Tween({ offset: 0, p:0 })
      .to({ offset: -step, p: 1 }, @duration)
      # .easing(TWEEN.Easing.Sinusoidal.InOut)
      .easing(TWEEN.Easing.Back.Out)
      .onUpdate(->
        es = it.getEasing @p
        currOffset = 415 + (@offset + offset)
        # currOffset *= es
        it.path.setAttribute 'startOffset', currOffset

        if @p is 1
          offset += @offset
      ).start()
      # ).repeat(@surpCnt).delay(@delay).start()
      # 
    
    @neck2 = new TWEEN.Tween({ y: -20, angle: 1, p:0 })
      .to({ y:0, angle: 0, p: 1 }, @duration/6)
      # .easing(TWEEN.Easing.Sinusoidal.InOut)
      .easing(TWEEN.Easing.Back.Out)
      .onUpdate(->
        it.adamsApple.setAttribute  'transform', "translate(0, #{@y})"
        # it.adamsLeft.setAttribute   'transform', "rotate(#{@angle},337,565)"
        # it.adamsRight.setAttribute    'transform', "rotate(#{-@angle},367,565)"
      # ).repeat(@surpCnt).delay(@delay+(@duration/2)).start()
      )

    @neck1 = new TWEEN.Tween({ y: 0, angle:0, p:0 })
      .to({ y:-20, angle:1, p: 1 }, @duration/6)
      # .easing(TWEEN.Easing.Sinusoidal.InOut)
      .easing(TWEEN.Easing.Back.Out)
      .onUpdate(->
        it.adamsApple.setAttribute    'transform', "translate(0, #{@y})"
        # it.adamsLeft.setAttribute     'transform', "rotate(#{@angle},337,565)"
        # it.adamsRight.setAttribute    'transform', "rotate(#{-@angle},367,565)"
      # ).repeat(@surpCnt).delay(@delay+(@duration/2)).start()
      ).chain(@neck2).delay((@delay/2)+(@duration/5)).start()


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