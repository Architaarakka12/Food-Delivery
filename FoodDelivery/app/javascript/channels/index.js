// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

$( document ).ready(function() {
	$(".dropdown-button").dropdown();

	$('.button-collapse').sideNav({
		menuWidth: 300, // Default is 240
		edge: 'right', // Choose the horizontal origin
		closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
	});


		// Show sideNav
		// $('.button-collapse').sideNav('show');
		// Hide sideNav
		// $('.button-collapse').sideNav('hide');
});
