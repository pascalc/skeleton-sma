var lastPostID;

function showFullMessage(postID){
    var element = $('#' + 'full' + postID);
    element.removeClass('hidden');
    element.hide();
    element.fadeIn('fast');


    $('#'+'partial' + postID).addClass('selected');

    var tempID1 = parseInt(lastPostID);
    var tempID2 = parseInt(postID);
    if(tempID1!=tempID2){			//Kollar att de två senaste posterna ej samma
        hideInfo(lastPostID)			//Om ej samma, hideInfo - förra			
    }
    lastPostID = postID;
}
function hideInfo(postID) {
    var element=  $('#'+'full' + postID);		//gör till element..
    element.addClass('hidden'); 			//Ska vara hidden
    $('#'+'partial' + postID).removeClass('selected');	//info ej selected
}

$(document).ready(function(){

	// Start stream via AJAX
	$("#start-button").click(function(e) {
		e.preventDefault();
        	$.post("http://localhost:7777/classify/stream", function(data) {
          		console.log(data);
        	});
      	});

	// Juggernaut
	var show = function(data){
		line = "<tr>" + data.text + "</tr>";
		$(line).hide().prependTo("#stream").fadeIn("slow");
	};

	var jug = new Juggernaut({
		secure: ('https:' == document.location.protocol),
		host: document.location.hostname,
		port: 8080
	});

	jug.subscribe("nosy", function(data){
	        show(data);
        	console.log("Got: " + data);
      	});
});
