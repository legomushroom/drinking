class Main
  constructor:->
    @vars()
    @fixIEPosition()
    @animate()
    @setInterval()

  setInterval:->
    @interval = setInterval @launch, 2*@duration
    @launch()

  reset:->
    @offset       = @startOffset
    @path.setAttribute 'startOffset', @startOffset
    @intervalCnt  = 0
    clearInterval @interval
    @setInterval()

  vars:->
    @animate  = @bind @animate, @
    @launch   = @bind @launch, @
    @path       = document.getElementById 'js-words-path'
    @realPath   = document.getElementById 'words-path'
    @pathLength = @realPath.getTotalLength()
    if @isFF() then @pathLength /= 1000000
    @adamsApple = document.getElementById 'js-adams-apple'
    @text = document.getElementById 'js-text'
    @surpCnt    = 2
    @delay      = 3000
    @duration   = 5000
    @startOffset = parseInt @path.getAttribute('startOffset'), 10
    @intervalCnt = 0
    @offset = @startOffset
  animate:->
    requestAnimationFrame(@animate)
    TWEEN.update()

  fixIEPosition:->
    if @isIE() or @isFF()
      @text.setAttribute 'transform', "translate(-2,1)"
      @shortenOffset()

  shortenOffset:->
    @startOffset = -800
    @offset = @startOffset
    @path.setAttribute 'startOffset', @startOffset

  launch:->
    if ++@intervalCnt > (2*@surpCnt)+1
      @reset()
    it = @
    step = @pathLength/@surpCnt
    @tween1 = new TWEEN.Tween({ offset: it.offset, p:0 })
      .to({ offset: it.offset-step, p: 1 }, @duration)
      # .easing(TWEEN.Easing.Sinusoidal.InOut)
      .easing(TWEEN.Easing.Sinusoidal.Out)
      .onUpdate(->
        it.path.setAttribute 'startOffset',  @offset
        it.offset = @offset
      )
      .onComplete(->
        it.tween2 = new TWEEN.Tween({ offsetReverse: it.offset, p:0 })
          .to({ offsetReverse: it.offset+50, p: 1 }, it.duration)
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
      .to({ y:0, angle: 0, p: 1 }, @duration/8)
      .easing(TWEEN.Easing.Back.Out)
      .onUpdate(->
        it.adamsApple.setAttribute  'transform', "translate(0, #{@y})"
      )
    @neck1 = new TWEEN.Tween({ y: 0, angle:0, p:0 })
      .to({ y:-15, angle:1, p: 1 }, @duration/10)
      .easing(TWEEN.Easing.Back.Out)
      .onUpdate(->
        it.adamsApple.setAttribute    'transform', "translate(0, #{@y})"
      ).chain(@neck2).delay(@duration-(@duration/10)).start()

  isIE:->
    if @isIECache then return @isIECache
    undef = undefined # Return value assumes failure.
    rv = -1
    ua = window.navigator.userAgent
    msie = ua.indexOf("MSIE ")
    trident = ua.indexOf("Trident/")
    if msie > 0
      
      # IE 10 or older => return version number
      rv = parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)), 10)
    else if trident > 0
      
      # IE 11 (or newer) => return version number
      rvNum = ua.indexOf("rv:")
      rv = parseInt(ua.substring(rvNum + 3, ua.indexOf(".", rvNum)), 10)
    @isIECache = (if (rv > -1) then rv else undef)
    @isIECache

  isFF:->
    navigator.userAgent.toLowerCase().indexOf('firefox') > -1


  bind:(func, context) ->
    wrapper = ->
      args = Array::slice.call(arguments)
      unshiftArgs = bindArgs.concat(args)
      func.apply context, unshiftArgs
    bindArgs = Array::slice.call(arguments, 2)
    wrapper

new Main