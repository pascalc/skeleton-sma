var prevID;

function showFullMessage(ID)
{
	var element = $('#' + 'full' + ID);
	element.removeClass('hidden');
	element.hide();
	element.fadeIn('fast');

	$('#'+'partial' + ID).addClass('selected');

	var prev = parseInt(prevID);
	var current = parseInt(ID);
	if(current!=prev){
		hideInfo(prevID)
	}
	prevID = ID;
}
