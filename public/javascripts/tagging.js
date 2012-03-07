var lastPostID;

function showInfo(postID) {
    var element=  $('#'+'details' + postID);
    element.removeClass('hidden');
    element.hide();
    element.fadeIn('fast');


    $('#'+'shortInfo' + postID).addClass('selected');

    var tempID1 = parseInt(lastPostID);
    var tempID2 = parseInt(postID);
    if(tempID1!=tempID2){
        hideInfo(lastPostID)
    }
    lastPostID = postID;
}
function hideInfo(postID) {
    var element=  $('#'+'details' + postID);
    element.addClass('hidden');
    $('#'+'shortInfo' + postID).removeClass('selected');
}

