(function() {
  var Main;

  Main = (function() {
    function Main() {
      this.vars();
      this.animate();
      this.launch();
    }

    Main.prototype.vars = function() {
      this.animate = this.bind(this.animate, this);
      this.path = document.getElementById('js-words-path');
      this.realPath = document.getElementById('words-path');
      this.pathLength = this.realPath.getTotalLength();
      this.easing = document.getElementById('js-custom-easing');
      this.easingLength = this.easing.getTotalLength();
      this.text = this.path.textContent;
      return this.surpCnt = 4;
    };

    Main.prototype.animate = function() {
      requestAnimationFrame(this.animate);
      return TWEEN.update();
    };

    Main.prototype.launch = function() {
      var it, offset, step;
      it = this;
      offset = 0;
      step = this.pathLength / this.surpCnt;
      return this.tween = new TWEEN.Tween({
        offset: 0,
        p: 0
      }).to({
        offset: -step,
        p: 1
      }, 5000).easing(TWEEN.Easing.Back.Out).onUpdate(function() {
        var currOffset, es;
        es = it.getEasing(this.p);
        currOffset = 415 + (this.offset + offset);
        it.path.setAttribute('startOffset', currOffset);
        if (this.p === 1) {
          return offset += this.offset;
        }
      }).repeat(this.surpCnt).delay(3000).start();
    };

    Main.prototype.getEasing = function(process) {
      return this.easing.getPointAtLength(this.easingLength - (process * this.easingLength)).y / 100;
    };

    Main.prototype.bind = function(func, context) {
      var bindArgs, wrapper;
      wrapper = function() {
        var args, unshiftArgs;
        args = Array.prototype.slice.call(arguments);
        unshiftArgs = bindArgs.concat(args);
        return func.apply(context, unshiftArgs);
      };
      bindArgs = Array.prototype.slice.call(arguments, 2);
      return wrapper;
    };

    return Main;

  })();

  new Main;

}).call(this);
