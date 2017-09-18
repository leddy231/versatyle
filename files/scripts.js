function toggleNavbar() {
		var navbar = document.getElementById("topnav");
		if (navbar.className === "") {
				navbar.className += " open";
		} else {
				navbar.className = "";
		}
}

function animate() {
		var home = document.getElementById("homeContainer");
		home.className += " reveal";
}
window.onload = animate;
