var lastPostID;

function happycode() {
    var selected= $('#selected').text();
    alert(selected);
}

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
	$('#tagInput'+postID).css('background-color','#FFFFFF');
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
    element.children("#tagItemIndex"+index).css('color','#FF0000').fadeOut('slow',function () 
{element.children("#tagItemIndex"+index).remove();});
}
function addTag(postID){
    var element=$('#postTags'+postID);

    var tag = $('#tagInput'+postID).val();

    $('#tagInput'+postID).val('');
    if(tag.trim()!=''){
    $('#tagInput'+postID).css('background-color','#FFFFFF');
    var count = $('ul#postTags'+postID+' li').length;

    element.append('<li id ="tagItemIndex'+count+'" onClick="hideTag('+postID+','+count+')" class="tagItem">'+tag+ '</li>');



    $('#tagItemIndex'+count).hide().css('color','#00CC33').fadeIn('slow');
    
    setTimeout(function() {
             $('#tagItemIndex'+count).stop().animate({'color': '#444'}, 1000).css('color', '#444');}, 1500);
    }
    else{
    $('#tagInput'+postID).css('background-color','#FFC0C0');
    }
}
function discard(postID){
    $.post('/tagging/discard/'+postID);
    $('#'+'details' + postID).css('background-color','#FFC0C0').fadeOut('slow',function(){$('#'+'details' + postID).remove()});

    $('#'+'shortInfo' + postID).removeClass('selected').css('background-color','#FFC0C0').slideUp('slow',function () 
{$('#'+'shortInfo' + postID).remove();updateList();});
    
}

function commit(postID) {
    var ul=$('ul#postTags'+postID);
    var numberOfTags = $('ul#postTags'+postID+' li').length;
    var tagsString = '';

    for (var i =0;i<=numberOfTags;i=i+1){

        if($('ul#postTags'+postID+' li:nth-child('+i+')').is(":visible")){
            if(i==1){
            tagsString = tagsString+$('ul#postTags'+postID+' li:nth-child('+i+')').text();
            }
            else{
            tagsString = tagsString+','+$('ul#postTags'+postID+' li:nth-child('+i+')').text();
            }
        }

    }
    $.post('/tagging/commit/'+postID, {tags:tagsString});

    $('#'+'details' + postID).css('background-color','#99CC99').fadeOut('slow',function(){$('#'+'details' + postID).remove();});
    $('#'+'shortInfo' + postID).removeClass('selected').css('background-color','#99CC99').slideUp('slow',function () 
{$('#'+'shortInfo' + postID).remove();updateList();});
}
function updateList(){
    $('tr.messageItem:nth-child(even)').css('background','#F0F0F0');
    $('tr.messageItem:nth-child(odd)').css('background','#FFFFFF');
}
