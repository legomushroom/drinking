class Main
  constructor:->
    @vars()
    @animate()
    @launch()
  vars:->
    @animate = @bind @animate, @
    @path = document.getElementById 'js-words-path'
    @text = @path.textContent
  animate:->
    requestAnimationFrame(@animate)
    TWEEN.update()

  launch:->
    it = @
    offset = 0
    @tween = new TWEEN.Tween({ offset: 0, p:0 })
      .to({ offset: 400, p: 1 }, 3000)
      .easing(TWEEN.Easing.Sinusoidal.InOut)
      .onUpdate(->
        it.path.setAttribute 'startOffset', @offset + offset
        if @p is 1
          offset += @offset
      ).repeat(10).delay(1000).start()

  bind:(func, context) ->
    wrapper = ->
      args = Array::slice.call(arguments)
      unshiftArgs = bindArgs.concat(args)
      func.apply context, unshiftArgs
    bindArgs = Array::slice.call(arguments, 2)
    wrapper

new Main