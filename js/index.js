(function () {

	// IIFE (Immediately Invoked Function Expression) -> é uma função em Javascript que é executada assim que definida.

	function myFunctionInput() {
		MyInput = document.getElementById("fname").value;
		//alert(MyInput);
		document.getElementById('demo').innerHTML = MyInput;
		return;
	}

	function myFunctionClick() {
		document.getElementById("demo7").textContent = 'PARÁGRAFO ALTERADO DINAMICAMENTE!';
		return;
	}

	document.getElementById("fname").addEventListener("input", myFunctionInput);
	//document.getElementById("fname").addEventListener("propertychange", myFunctionInput);

	document.getElementById("btnTeste").addEventListener("click", myFunctionClick);

})()