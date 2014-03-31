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
      this.adamsApple = document.getElementById('js-adams-apple');
      this.adamsLeft = document.getElementById('js-adams-left');
      this.adamsRight = document.getElementById('js-adams-right');
      this.text = this.path.textContent;
      this.surpCnt = 2;
      this.delay = 3000;
      return this.duration = 5000;
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
      this.tween = new TWEEN.Tween({
        offset: 0,
        p: 0
      }).to({
        offset: -step,
        p: 1
      }, this.duration).easing(TWEEN.Easing.Back.Out).onUpdate(function() {
        var currOffset, es;
        es = it.getEasing(this.p);
        currOffset = 415 + (this.offset + offset);
        it.path.setAttribute('startOffset', currOffset);
        if (this.p === 1) {
          return offset += this.offset;
        }
      }).start();
      this.neck2 = new TWEEN.Tween({
        y: -20,
        angle: 1,
        p: 0
      }).to({
        y: 0,
        angle: 0,
        p: 1
      }, this.duration / 6).easing(TWEEN.Easing.Back.Out).onUpdate(function() {
        return it.adamsApple.setAttribute('transform', "translate(0, " + this.y + ")");
      });
      return this.neck1 = new TWEEN.Tween({
        y: 0,
        angle: 0,
        p: 0
      }).to({
        y: -20,
        angle: 1,
        p: 1
      }, this.duration / 6).easing(TWEEN.Easing.Back.Out).onUpdate(function() {
        return it.adamsApple.setAttribute('transform', "translate(0, " + this.y + ")");
      }).chain(this.neck2).delay((this.delay / 2) + (this.duration / 5)).start();
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
