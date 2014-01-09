function makeGreen() {
	var iframe = document.getElementsByTagName('iframe')[0]
	var doc = iframe.contentWindow.document
	doc.body.style.backgroundColor = 'green'
}