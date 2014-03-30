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
      return this.text = this.path.textContent;
    };

    Main.prototype.animate = function() {
      requestAnimationFrame(this.animate);
      return TWEEN.update();
    };

    Main.prototype.launch = function() {
      var it, offset;
      it = this;
      offset = 0;
      return this.tween = new TWEEN.Tween({
        offset: 0,
        p: 0
      }).to({
        offset: 400,
        p: 1
      }, 5000).onUpdate(function() {
        it.path.setAttribute('startOffset', this.offset);
        return console.log(this.p);
      }).start();
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
