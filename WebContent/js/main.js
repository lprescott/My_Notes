function post(path, params, method) {
	method = method || "post"; // Set method to post by default if not
								// specified.

	// The rest of this code assumes you are not using a library.
	// It can be made less wordy if you use one.
	var form = document.createElement("form");
	form.setAttribute("method", method);
	form.setAttribute("action", path);

	for ( var key in params) {
		if (params.hasOwnProperty(key)) {
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", key);
			hiddenField.setAttribute("value", params[key]);

			form.appendChild(hiddenField);
		}
	}

	document.body.appendChild(form);
	form.submit();
}

// onclick="viewTextArea('${row.NOTE_ID}_textarea')
function viewTextArea(note_id) {
	var x = document.getElementsByClassName(note_id + "_dropdown");
	for (var i = x.length - 1; i >= 0; i--) {
		if(x[i].classList.contains("fa-caret-up")){
			x[i].classList.remove("fa-caret-up");
			x[i].classList.add("fa-caret-down");
		} else{
			x[i].classList.remove("fa-caret-down");
			x[i].classList.add("fa-caret-up");
		}
	}
	
	var y = document.getElementById(note_id + "_textarea");
	
		if (y.style.display === "none") {
			y.style.display = "block";
		} else {
			y.style.display = "none";
		}
	
}

