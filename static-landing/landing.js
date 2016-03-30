(function() {
	"use strict";
	var toggles = document.querySelectorAll(".menuButton");
	for (var i = toggles.length - 1; i >= 0; i--) { var toggle = toggles[i]; toggleHandler(toggle); };
	function toggleHandler(toggle) {
		toggle.addEventListener( "click", function(e) {
			e.preventDefault();
			(this.classList.contains("is-active") === true) ? this.classList.remove("is-active") : this.classList.add("is-active");
		});
	}
})();

(function() {
	"use strict";
	window.onscroll = function() {
		if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
			document.getElementById("NavigationBar").classList.add("opaque");
		} else {
			document.getElementById("NavigationBar").classList.remove("opaque");
		}
	};
})();
