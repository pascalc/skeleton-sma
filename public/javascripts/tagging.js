var lastPostID;

function showInfo(postID) {
    var element=  $('#'+'details' + postID);
    element.removeClass('hidden');
    hideInfo(lastPostID)
    lastPostID = postID;
}
function hideInfo(postID) {
    var element=  $('#'+'details' + postID);
    element.addClass('hidden');
}

