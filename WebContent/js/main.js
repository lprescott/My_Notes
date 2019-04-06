
 /**
 * https://stackoverflow.com/a/133997/6011169
 * 
 * sends a request to the specified url from a form. this will change the window location.
 * @param {string} path the path to send the post request to
 * @param {object} params the paramiters to add to the url
 * @param {string} [method=post] the method to use on the form
 */

function post(path, params, method) {
    method = method || "post"; // Set method to post by default if not specified.

    // The rest of this code assumes you are not using a library.
    // It can be made less wordy if you use one.
    var form = document.createElement("form");
    form.setAttribute("method", method);
    form.setAttribute("action", path);

    for(var key in params) {
        if(params.hasOwnProperty(key)) {
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

/**
 * this toggle simply changes the toggles icon and hides or shows a textarea
 * 
 * @param note_id the id concatenated with '_dropdown' and '_textarea' used to toggle text area showing
 * @returns
 */
function viewTextArea(note_id) {
	var x = document.getElementsByClassName(note_id + "_dropdown");
	for (var i = x.length - 1; i >= 0; i--) {
		if (x[i].classList.contains("fa-caret-up")) {
			x[i].classList.remove("fa-caret-up");
			x[i].classList.add("fa-caret-down");
		} else {
			x[i].classList.remove("fa-caret-down");
			x[i].classList.add("fa-caret-up");
		}
	}

	var y = document.getElementById(note_id + "_textarea");

	if (y != null) {
		if (y.style.display === "none") {
			y.style.display = "block";
		} else {
			y.style.display = "none";
		}
	}
	
	var z = document.getElementById(note_id + "_ellipsis");

	if (z != null) {
		if (z.style.display === "none") {
			z.style.display = "block";
		} else {
			z.style.display = "none";
		}
	}

}

/**
 * this shows a div 'new_note'
 * 
 * @returns
 */
function viewNewNote() {
	var z = document.getElementById("new_note");

	if (z.style.display === "none") {
		z.style.display = "block";
	} else {
		z.style.display = "none";
	}
}

/**
 * this hides a div 'new_note'
 * 
 * @returns
 */
function hideNewNote() {
	var z = document.getElementById("new_note");

	if (z.style.display === "block") {
		z.style.display = "none";
	} else {
		z.style.display = "block";
	}
}

/**
 * this adjusts the height of a textarea on keyboard input
 * 
 * @returns
 */
function adjustTextArea() {
	var x = document.getElementsByClassName("textarea");

	for (var i = x.length - 1; i >= 0; i--) {
		x[i].style.height = "5px";
		x[i].style.height = (element.scrollHeight) + "px";

	}
}

/**
 * this adjusts the height of a textarea on page load
 * 
 * @returns
 */
function setTextareaHeight(){
	var x = document.getElementsByClassName("note-text");
	for (var i = x.length - 1; i >= 0; i--) {
		x[i].style.height = x[i].scrollHeight + "px";	
	}
}