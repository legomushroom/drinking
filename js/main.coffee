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
    @tween = new TWEEN.Tween({ offset: 0 })
      .to({ offset: 2000 }, 30000)
      .onUpdate(->
        it.path.setAttribute 'startOffset', @offset
      ).start()

  bind:(func, context) ->
    wrapper = ->
      args = Array::slice.call(arguments)
      unshiftArgs = bindArgs.concat(args)
      func.apply context, unshiftArgs
    bindArgs = Array::slice.call(arguments, 2)
    wrapper


new Main