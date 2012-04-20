/**
 * @author Shinichi
 * this is script file for static graph.
 * based on 5.4.3.5 in ADD.
 */

// -function isOutOfDefault-
// Checks if new time scope is out of default or not.
var isOutOfDefault = function (inputStartTime, inputEndTime, defaultStartTime, defaultEndTime) 
{
  // return false if either startTime or endTime is out of scope.
  if (inputStartTime < defaultStartTime || defaultEndTime < inputEndTime)
    return false;
  else
    return true;
};
// -function setPlotArray-
// Separates current time scope to "seprateNumber" time scope, and in each time scope, the number
// and the percentage of tweets in "taggedDatasets are calculated and stored to "plotArray"
var setPlotArray = function (datasets, totalTweet, separateNumber, startTime, endTime) 
{
  var currentNumber;
  var plotArray = [];

  // separate time array
  var separatedTime = [];
  var interval = Math.round ((endTime - startTime) / separateNumber);

  // the number of elements of this array should be same as separateNumber + 1
  for (var i = 0; i < separateNumber; i++) 
  {
    separatedTime.push(startTime + i * interval);
  }
  separatedTime.push (endTime);
  // in order to avoid ignoring endTime because of rounding
  var dammyStart = startTime - interval;
  // for the result of the first element

  // class for inside array
  function plotObject (tagName) 
  {
    this.tagName = tagName;
    this.number = new Array;
  }

  for(var i = 0, i_len = datasets.length; i < i_len; i++)// for number of tags
  {
    plotArray[i] = new plotObject (datasets[i].tagName);
    // name of tag

    // j : for timeArray
    // k : for separatedTime
    var j_len = datasets[i].timeArray.length;

    // first check time before dammyStart
    for (var j = 0; j < j_len; j++) 
    {
      if (dammyStart <= datasets[i].timeArray[j])
        break;
    }

    for (var k = 0; j < j_len, k < separateNumber + 1; k++) 
    {
      // initialization
      currentNumber = 0;
      if (datasets[i].timeArray[j] < separatedTime[k]) 
      {
        currentNumber++;
        j++;
        if (j < j_len) 
        {
          while (datasets[i].timeArray[j] < separatedTime[k]) 
          {
            currentNumber++;
            j++;
            if (j_len <= j)
              break;
          }
        }
        plotArray[i].number.push ([separatedTime[k], currentNumber]);
        // number
        //plotArray[i].percent.push([separatedTime[k], currentNumber / 10000]);    // percent
      } else {
        plotArray[i].number.push ([separatedTime[k], 0]);
      }
    }
    // if all separatedTime hasn't been considered
    while (k < separateNumber + 1) 
    {
      plotArray[i].number.push ([separatedTime[k], 0]);
      //plotArray[i].percent.push([separatedTime[k], 0]);
      k++;
    }
  }
  return plotArray;
};

// -function drawStaticGraph-
// Draws data in "plotArray" onto the graph.
var drawStaticGraph = function (array) 
{
  $(function () 
  {
    // first correct the timestamps - they are recorded as the daily
    // midnights in UTC+0100, but Flot always displays dates in UTC
    // so we have to add one hour to hit the midnights in the plot
    //for(var i = 0; i < d.length; ++i)
    //d[i][0] += 60 * 60 * 1000;
    // helper for returning the weekends in a period
    function weekendAreas (axes) 
    {
      var markings = [];
      var d = new Date (axes.xaxis.min);
      // go to the first Saturday
      d.setUTCDate (d.getUTCDate () - ((d.getUTCDay () + 1) % 7));
      d.setUTCSeconds (0);
      d.setUTCMinutes (0);
      d.setUTCHours (0);
      var i = d.getTime ();
      do 
      {
        // when we don't set yaxis, the rectangle automatically
        // extends to infinity upwards and downwards
        markings.push(
        {
          xaxis : {
            from : i,
            to : i + 2 * 24 * 60 * 60 * 1000
          }
        });
        i += 7 * 24 * 60 * 60 * 1000;
      } while (i < axes.xaxis.max);
      return markings;
    }

    // for first plot
    var options = {
      xaxis : {
        mode : "time",
        tickLength : 5
      },
      selection : {
        mode : "x"
      },
      yaxes : [{
        min : 0
      }, {
        position : "right"
      }],
      grid : {
        markings : weekendAreas
      }
    };
    // convert for plot format
    var data = [];
    for (var m = 0; m < array.length; m++) 
    {
      data.push (
      {
        data : array[m].number,
        label : array[m].tagName + ": Number"
      });
    }

    // plot
    var plot = $.plot ($("#placeholder"), data, options);

    // zooming
    $("#placeholder").bind ("plotselected", function (event, ranges) 
    {
      plot = $.plot ($("#placeholder"), data, $.extend (true, {}, options, 
      {
        xaxis : {
          min : ranges.xaxis.from,
          max : ranges.xaxis.to
        }
      }));
    });
  });
};


// class for taggedDatasets
function taggedObject (tagName) 
{
  this.tagName = tagName;
  this.timeArray = new Array;
} 

// parameters for function 'storeDataToArray'
var countOfConvertedTags = 0;   // Number of tags already stored into array
var taggedDatasets = [];        // main array
var selectedTags = [];

var storeDataToArray = function (data)
{
  taggedDatasets.push (new taggedObject (selectedTags[countOfConvertedTags]));
  for (var j = 0; j < data.length; j++) 
  {
    // convert date
    var milliDate = Date.parse (data[j].created_at);
    //var offset = myDate.getTimezoneOffset() * 1000;
    //var withOffset = myDate.getTime();
    //var withoutOffset = withOffset - offset;
    taggedDatasets[countOfConvertedTags].timeArray.push (milliDate);
  }
  countOfConvertedTags++;  
}

// main function for getting data
// has to calculate recursively
var recursive = function (startTime, endTime, separateNumber, plotArray, totalTweetsArray, recursiveCount)
{
  var filters = "%7B" + "%22" + selectedTags[recursiveCount] + "%22:0.9" + "%7D";
  var parameters = "thresholds=" + filters + "&start_time=" + parseInt (startTime / 1000) 
      + "&end_time=" + parseInt (endTime / 1000) + "&limit=1000";
  var url = "../results/data?";
  url = url.concat (parameters);
  alert(url);  
  // send a HTTP GET request to the classifier server to get the data
  $.ajax (
  {
    type : "GET",
    url : url,
    dataType : "json",
    success : function (data) 
    {
      storeDataToArray (data);
    },
    error : function (dammy, text) 
    {
      alert(text);
    }
  });
  
  // if ajax connection competed, go to next step
  $(document).ajaxComplete (function () 
  { 
    // data of all tags should be stored
    if (countOfConvertedTags < selectedTags.length) {
      recursive (startTime, endTime, separateNumber, plotArray, totalTweetsArray, countOfConvertedTags);      
    } 
    else if (countOfConvertedTags === selectedTags.length) 
    {
      plotArray = setPlotArray (taggedDatasets, totalTweetsArray, separateNumber, startTime, endTime);
      drawStaticGraph (plotArray);
    }
  });  
}

// -function getData-
// Gets data from database based on current selected tags and stores them to "taggedDatasets"
var getData = function (startTime, endTime, separateNumber, plotArray, totalTweetsArray) 
{
  // initialization
  countOfConvertedTags = 0;
  currentNumber = 0; 
  if (taggedDatasets.length !== 0) taggedDatasets.length = 0;
  recursive(startTime, endTime, separateNumber, plotArray, totalTweetsArray, 0);
};

// calculate separateNumber depending on startTime and endTime
var calcSeparateNumber = function (startTime, endTime)
{
  return Math.round ((endTime - startTime) / 10000000);
}

// -function displayStaticGraph-
// main function for displaying static graph.
var displayStaticGraph = function () {
  // These parameters can be changed.------------------------------

  // time is in millisecond
  // default start time and end time
  var dateDammy1 = new Date();
  var dateDammy2 = dateDammy1.getTime();
  var defaultStartTime = dateDammy2 - 7 * 24 * 3600 * 1000;
  var defaultEndTime = dateDammy2;

  var separateNumber = 100;
  //--------------------------------------------------------------

  var startTime = defaultStartTime;
  var endTime = defaultEndTime;
  var plotArray, taggedDatasets;
  var totalTweetsArray = 100;             // now just dammy

  // initial time for calendar
  var initialStartYear = new Date();
  var initialStartMonth = new Date();
  var initialStartDate = new Date();
  initialStartYear.getYear();
  initialStartMonth.getMonth();
  initialStartDate.getDate();
  var initialEndYear = new Date();
  var initialEndMonth = new Date();
  var initialEndDate = new Date();
  initialEndYear.getYear();
  initialEndMonth.getMonth();
  initialEndDate.getDate();

  var calendarInitialStartTime = parseInt (String (initialStartYear) 
      + String (initialStartMonth) + String (initialStartDate));
  var calendarInitialEndTime = parseInt (String (initialEndYear) 
      + String (initialEndMonth) + String (initialEndDate));

  /*
  // maybe we will show the default data first?
  taggedDatasets = this.getData(selectedTags, startTime, endTime);
  plotArray = this.setPlotArray(taggedDatasets, totalTweetsArray, separateNumber, startTime, endTime);
  this.drawStaticGraph(plotArray);
  */

  // when new tags are selected
  // Also, when this function is called first, first tags should be specified.
  $("#tagSelected-box").change (function ()   // if the tags are changed and entered
  {
    selectedTags = ($("#tagSelected-box").val ());
    if (selectedTags.match (/\S/g))           // space check by regular expression
    {      
      selectedTags = selectedTags.split (",");       // split with comma and store to array
      separateNumber = calcSeparateNumber (startTime, endTime);
      //alert (separateNumber);
      getData (startTime, endTime, separateNumber, plotArray, totalTweetsArray);
    }
  });
  
  // calendar setup
  var startCal = Calendar.setup (
  {
    cont : "start-calendar-container",
    inputField : "start-calendar-input",
    showTime : true,
    selection : [calendarInitialStartTime], // initialize
    min : 20070101, // minimum date
    max : 20201231, // maximum date
    dateFormat : "%s", // format of date

    // event when date is changed
    onSelect : function () 
    {
      // get new startTime
      var tmp = this.selection.get ();
      tmp = Calendar.intToDate (tmp);
      tmp = Calendar.printDate (tmp, "%s");
      startTime = tmp * 1000;

      // for displaying
      var date = this.selection.get ();
      date = Calendar.intToDate (date);
      date = Calendar.printDate (date, "%A, %B %d, %Y");
      var ta = document.getElementById ("start-calendar-input");
      ta.value = date;
      var tempEnd = ($("#end-calendar-input").val ());
      // get the value of input of end calendar
      if (tempEnd.match (/\S/g))// space check with regular expression
      {
        if (!(startTime < endTime)) 
        {
          alert ("Enter startTime < endTime");
        } else {
          // if new time scope is outside of default time scope
          if (isOutOfDefault (startTime, endTime, defaultStartTime, defaultEndTime)) 
          {
            //taggedDatasets = staticGraph.getData(selectedTags, startTime, endTime);
            defaultStartTime = startTime;
            defaultEndTime = endTime;
          }
          plotArray = setPlotArray (taggedDatasets, totalTweetsArray, separateNumber, startTime, endTime);
          drawStaticGraph (plotArray);
        }
      }
    },
    // event when time is changed
    onTimeChange : function () 
    {
      var hours = this.getHours ();
      var minutes = this.getMinutes ();
      // for displaying
      /*
       var time = hours + " : " + minutes;
       var tibx = document.getElementById("start-calendar-time");
       tibx.value = time;
       */
    }
  });

  var endCal = Calendar.setup (
  {
    cont : "end-calendar-container",
    inputField : "end-calendar-input",
    showTime : true,
    selection : [calendarInitialEndTime], // initialize
    min : 20070101, // minimum date
    max : 20201231, // maximum date
    dateFormat : "%s", // format of date

    // event when date is changed
    onSelect : function () 
    {
      // get new startTime
      var tmp = this.selection.get ();
      tmp = Calendar.intToDate (tmp);
      tmp = Calendar.printDate (tmp, "%s");
      endTime = tmp * 1000;

      // for displaying
      var date = this.selection.get ();
      date = Calendar.intToDate (date);
      date = Calendar.printDate (date, "%A, %B %d, %Y");
      var ta = document.getElementById ("end-calendar-input");
      ta.value = date;
      var tempStart = ($("#start-calendar-input").val ());
      // get the value of input of start calendar
      if (tempStart.match (/\S/g)) // space check with regular expression
      {
        if (!(startTime < endTime)) 
        {
          alert ("Enter startTime < endTime");
        } else {
          // if new time scope is outside of default time scope
          if (isOutOfDefault(startTime, endTime, defaultStartTime, defaultEndTime)) 
          {
            getData (startTime, endTime, separateNumber, plotArray, totalTweetsArray);
            defaultStartTime = startTime;
            defaultEndTime = endTime;
          }
          plotArray = setPlotArray (taggedDatasets, totalTweetsArray, separateNumber, startTime, endTime);
          drawStaticGraph (plotArray);
          //this.drawStaticGraph(plotArray, isShowNum, isShowPercent);
        }
      }
    },
    // event when time is changed
    onTimeChange : function () 
    {
      var hours = this.getHours ();
      var minutes = this.getMinutes ();
      // for displaying
      /*
       var time = hours + " : " + minutes;
       var tibx = document.getElementById("end-calendar-time");
       tibx.value = time;
       */
    }
  });
};
// implement
displayStaticGraph ();

