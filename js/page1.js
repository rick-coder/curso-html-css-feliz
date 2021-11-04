(function () {

	// IIFE (Immediately Invoked Function Expression) -> é uma função em Javascript que é executada assim que definida.

	myFunction = function() {
		alert('Funcionou!\nJavascript => AutoHotkey => Javascript');
		return;
	}

	myFunctionMyButton1 = function() {
		AHK('MyButton1');
		return;
	}

	myFunctionMyButton2 = function() {
		AHK('MyButton2');
		return;
	}

	myFunctionMyButton3 = function() {
		AHK('Hello');
		return;
	}

	myFunctionMyButton4 = function() {
		AHK('RunMyJSFunction');
		return;
	}

	document.getElementById("MyButton1").addEventListener("click", myFunctionMyButton1);
	document.getElementById("MyButton2").addEventListener("click", myFunctionMyButton2);
	document.getElementById("MyButton3").addEventListener("click", myFunctionMyButton3);
	document.getElementById("MyButton4").addEventListener("click", myFunctionMyButton4);

})()