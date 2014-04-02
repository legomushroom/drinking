(function() {
  var Main;

  Main = (function() {
    function Main() {
      this.vars();
      this.fixIEPosition();
      this.animate();
      this.setInterval();
    }

    Main.prototype.setInterval = function() {
      this.interval = setInterval(this.launch, 2 * this.duration);
      return this.launch();
    };

    Main.prototype.reset = function() {
      this.offset = this.startOffset;
      this.path.setAttribute('startOffset', this.startOffset);
      this.intervalCnt = 0;
      clearInterval(this.interval);
      return this.setInterval();
    };

    Main.prototype.vars = function() {
      this.animate = this.bind(this.animate, this);
      this.launch = this.bind(this.launch, this);
      this.path = document.getElementById('js-words-path');
      this.realPath = document.getElementById('words-path');
      this.pathLength = this.realPath.getTotalLength();
      if (this.isFF()) {
        this.pathLength /= 1000000;
      }
      this.adamsApple = document.getElementById('js-adams-apple');
      this.text = document.getElementById('js-text');
      this.surpCnt = 2;
      this.delay = 3000;
      this.duration = 5000;
      this.startOffset = parseInt(this.path.getAttribute('startOffset'), 10);
      this.intervalCnt = 0;
      return this.offset = this.startOffset;
    };

    Main.prototype.animate = function() {
      requestAnimationFrame(this.animate);
      return TWEEN.update();
    };

    Main.prototype.fixIEPosition = function() {
      if (this.isIE() || this.isFF()) {
        this.text.setAttribute('transform', "translate(-2,1)");
        return this.shortenOffset();
      }
    };

    Main.prototype.shortenOffset = function() {
      this.startOffset = -800;
      this.offset = this.startOffset;
      return this.path.setAttribute('startOffset', this.startOffset);
    };

    Main.prototype.launch = function() {
      var it, step;
      if (++this.intervalCnt > (2 * this.surpCnt) + 1) {
        this.reset();
      }
      it = this;
      step = this.pathLength / this.surpCnt;
      return this.tween1 = new TWEEN.Tween({
        offset: it.offset,
        p: 0
      }).to({
        offset: it.offset - step,
        p: 1
      }, this.duration).easing(TWEEN.Easing.Sinusoidal.Out).onUpdate(function() {
        it.path.setAttribute('startOffset', this.offset);
        return it.offset = this.offset;
      }).onComplete(function() {
        return it.tween2 = new TWEEN.Tween({
          offsetReverse: it.offset,
          p: 0
        }).to({
          offsetReverse: it.offset + 50,
          p: 1
        }, it.duration).easing(TWEEN.Easing.Elastic.Out).onUpdate(function() {
          it.path.setAttribute('startOffset', this.offsetReverse);
          return it.offset = this.offsetReverse;
        }).start();
      }).onStart(function() {
        return it.gulp();
      }).start();
    };

    Main.prototype.gulp = function() {
      var it;
      it = this;
      this.neck2 = new TWEEN.Tween({
        y: -15,
        angle: 1,
        p: 0
      }).to({
        y: 0,
        angle: 0,
        p: 1
      }, this.duration / 8).easing(TWEEN.Easing.Back.Out).onUpdate(function() {
        return it.adamsApple.setAttribute('transform', "translate(0, " + this.y + ")");
      });
      return this.neck1 = new TWEEN.Tween({
        y: 0,
        angle: 0,
        p: 0
      }).to({
        y: -15,
        angle: 1,
        p: 1
      }, this.duration / 10).easing(TWEEN.Easing.Back.Out).onUpdate(function() {
        return it.adamsApple.setAttribute('transform', "translate(0, " + this.y + ")");
      }).chain(this.neck2).delay(this.duration - (this.duration / 10)).start();
    };

    Main.prototype.isIE = function() {
      var msie, rv, rvNum, trident, ua, undef;
      if (this.isIECache) {
        return this.isIECache;
      }
      undef = void 0;
      rv = -1;
      ua = window.navigator.userAgent;
      msie = ua.indexOf("MSIE ");
      trident = ua.indexOf("Trident/");
      if (msie > 0) {
        rv = parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)), 10);
      } else if (trident > 0) {
        rvNum = ua.indexOf("rv:");
        rv = parseInt(ua.substring(rvNum + 3, ua.indexOf(".", rvNum)), 10);
      }
      this.isIECache = (rv > -1 ? rv : undef);
      return this.isIECache;
    };

    Main.prototype.isFF = function() {
      return navigator.userAgent.toLowerCase().indexOf('firefox') > -1;
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
