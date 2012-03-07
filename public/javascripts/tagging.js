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
    element.children("#tagItemIndex"+index).css('color','#FF0000').fadeOut('slow');
}
function addTag(postID){
    var element=$('#postTags'+postID);

    var tag = $('#tagInput'+postID).val();

    $('#tagInput'+postID).val('');

    var count = $('ul#postTags'+postID+' li').length;

    element.append('<li id ="tagItemIndex'+count+'" onClick="hideTag('+postID+','+count+')" class="tagItem">'+tag+ '</li>');



    $('#tagItemIndex'+count).hide().css('color','#00CC33').fadeIn('slow');
    setTimeout(function() {
             $('#tagItemIndex'+count).css('color', '#444');
    }, 1500);
}
function discard(postID){
    $.post('/tagging/discard/'+postID);
    $('#'+'details' + postID).css('background-color','#FFC0C0').fadeOut('slow');
    $('#'+'shortInfo' + postID).removeClass('selected').css('background-color','#FFC0C0').fadeOut('slow');
}

function commit(postID) {
    var ul=$('#postTags'+postID);
    var numberOfTags = $('ul#postTags'+postID+' li').length;

    var tagsString = '';

    for (var i =0;i<numberOfTags;i=i+1)
    {
        if(ul.children('#tagItemIndex'+i).is(":visible")){
            tagsString = tagsString+ul.children('#tagItemIndex'+i).val();
        }
    }
    alert(tagsString)
    $.post('/tagging/commit/'+postID, {tags:tagsString});

    $('#'+'details' + postID).css('background-color','#99CC99').fadeOut('slow');
    $('#'+'shortInfo' + postID).removeClass('selected').css('background-color','#99CC99').fadeOut('slow');
}
