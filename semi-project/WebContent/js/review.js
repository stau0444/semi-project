if (window.innerWidth < 1200) {
	$('#carouselExampleIndicators').hide();
	$()
} else {
	$('#carouselExampleIndicators').show();
}

$('exampleModal').on('show.bs.modal', function() {
	parent.resizeTo(window.innerWidth, window.innerHeight);
});

$(window).resize(function() {
	if (window.innerWidth < 1200) {
		$('#carouselExampleIndicators').hide();
		$()
	} else {
		$('#carouselExampleIndicators').show();
	}
});
