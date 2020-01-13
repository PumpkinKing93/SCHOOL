// CSci130 - Web Programming

/////////////
// Events
/////////////

// jQuery
$(document).ready(function() {
  // code
})
// Vanilla JS
document.addEventListener('DOMContentLoaded', function() {
  // code
})


// document is the selector
// ready is the type of action (it takes as an input a function)
$(document).ready(function(){
  alert("Hello World!");
  $("#blackBox").hide(); // note the # sign to get the ID
});

// same as:
// in the following case, we access the element blackbox through the DOM with its ID
window.onload = function() {
  alert( "Hello World!" );
  document.getElementById("blackBox").style.display = "none"; // hide the element that has the ID blackbox
};


// jQuery
$('a').click(function() {
  // code
})
// Vanilla JS
[].forEach.call(document.querySelectorAll('a'), function(el) {
  el.addEventListener('click', function() {
    // code
  })
})


////////////
// Selectors
////////////

// jQuery
var divs = $('div')
// Vanilla JS
var divs = document.querySelectorAll('div')

// jQuery
var newDiv = $('<div/>')
// Vanilla JS
var newDiv = document.createElement('div')
Attributes

// jQuery
$('img').filter(':first').attr('alt', 'My image')
// Vanilla JS
document.querySelector('img').setAttribute('alt', 'My image')
Classes

// jQuery
newDiv.addClass('foo')
// Vanilla
newDiv.classList.add('foo')

// jQuery
newDiv.toggleClass('foo')
// Vanilla
newDiv.classList.toggle('foo')

//////////////////
// Manipulation //
//////////////////

// jQuery
$('body').append($('<p/>'))
// Vanilla
document.body.appendChild(document.createElement('p'))

// jQuery
var clonedElement = $('#about').clone()
// Vanilla
var clonedElement = document.getElementById('about').cloneNode(true)

// jQuery
$('#wrap').empty()
// Vanilla
var wrap = document.getElementById('wrap')
while(wrap.firstChild) wrap.removeChild(wrap.firstChild)
Transversing

// jQuery
var parent = $('#about').parent()
// Vanilla
var parent = document.getElementById('about').parentNode

// jQuery
if($('#wrap').is(':empty'))
// Vanilla
if(!document.getElementById('wrap').hasChildNodes())

// jQuery
var nextElement = $('#wrap').next()
// Vanilla
var nextElement = document.getElementById('wrap').nextSibling