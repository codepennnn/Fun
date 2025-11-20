<style>
/* make the container the positioning context */
.SearchCheckBoxList {
  position: relative;      /* REQUIRED so .floatDiv is positioned relative to this container */
  width: 100%;             /* change 287% to a sane width — adjust as needed */
  max-width: 550px;        /* optional: limit width */
}

/* floatDiv sits directly below the button and matches container width */
.SearchCheckBoxList .floatDiv {
  position: absolute;
  top: calc(100% + 4px);   /* just below the button; tweak spacing */
  left: 0;
  width: 100%;
  box-shadow: 0 6px 12px rgba(0,0,0,0.18);
  z-index: 1000;
  display: none;           /* default hidden */
  background: #fff;
  padding: 6px;
}

/* when open, use a class instead of inline styles */
.SearchCheckBoxList.open .floatDiv {
  display: block;
}

/* style the button so it doesn't overflow */
.SearchCheckBoxList .selectArea {
  box-sizing: border-box;
}
</style>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {

  // Toggle dropdown for the clicked button
  window.togglefloatDiv = function(btn) {
    // find nearest SearchCheckBoxList container
    var container = btn.closest('.SearchCheckBoxList');
    if (!container) return;

    // close other containers
    document.querySelectorAll('.SearchCheckBoxList.open').forEach(function(el) {
      if (el !== container) el.classList.remove('open');
    });

    // toggle this one
    container.classList.toggle('open');

    // OPTIONAL: focus the input inside when opened
    if (container.classList.contains('open')) {
      var input = container.querySelector('input[oninput="filterCheckBox(this)"], input[type="text"]');
      if (input) input.focus();
    }
  };

  // Close when clicking outside any SearchCheckBoxList
  document.addEventListener('click', function(e) {
    if (!e.target.closest('.SearchCheckBoxList')) {
      document.querySelectorAll('.SearchCheckBoxList.open').forEach(function(el) {
        el.classList.remove('open');
      });
    }
  });

  // Close on ESC
  document.addEventListener('keydown', function(e){
    if (e.key === 'Escape') {
      document.querySelectorAll('.SearchCheckBoxList.open').forEach(function(el) {
        el.classList.remove('open');
      });
    }
  });

});
</script>

