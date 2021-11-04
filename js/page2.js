(function () {

	// IIFE (Immediately Invoked Function Expression) -> é uma função em Javascript que é executada assim que definida.

	function my_js_and_ahk_function() {                   // Deixa que o cálculo seja executado pelo AutoHotkey, em vez do Javascript
		let result = AHK('multiply_ahk', 3, 9);           // Chama a função AutoHotkey "multiply_ahk", declarada no arquivo principal (.ahk)

		alert('Função em Javascript que chama outra função em AutoHotkey para executar o cálculo: ' + result + '.');
		return;
	}

	function normal_js_function() {
		let result = multiply_js(3, 9);
		alert('Cálculo executado somente em Javascript: ' + result + '.');
		return;
	}

	function multiply_js(a, b) {
		return a * b;
	}

	document.getElementById("button_my_js_and_ahk_function").addEventListener("click", my_js_and_ahk_function);
	document.getElementById("button_normal_js_function").addEventListener("click", normal_js_function);

})()