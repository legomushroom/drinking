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
      var it;
      it = this;
      return this.tween = new TWEEN.Tween({
        offset: 0
      }).to({
        offset: 2000
      }, 30000).onUpdate(function() {
        return it.path.setAttribute('startOffset', this.offset);
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
