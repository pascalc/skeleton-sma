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
function hideTag(postID,index){
    var element=$('#postTags'+postID);
   element.children("#tagItemIndex"+index).fadeOut('slow');
}
function addTag(postID){
    var element=$('#postTags'+postID);

    var tag = $('#tagInput'+postID).val();

    var count = $('ul#postTags'+postID+' li').length;

    element.append('<li id ="tagItemIndex'+count+'" onClick="hideTag('+postID+','+count+')" class="tagItem">'+tag+ '</li>');
}
