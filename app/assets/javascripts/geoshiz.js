//   var coaster_enable_geolocation = function() {
// 		if (navigator.geolocation) {
// 		  navigator.geolocation.getCurrentPosition(coaster_update_coords, coaster_error);
// 		} else {
// 		  coaster_error('not supported');
// 		}
// 		return false
// 	}

// 	function coaster_update_coords(position) {
// 		user_id = $('#user_id').val()
// 		$.ajax({
// 		  url: '/users/'+user_id+'/update_geolocation',
// 		  data: { latitude: position.coords.latitude, longitude: position.coords.longitude },
// 		  success: function(data) {
// 		  	// var t = setTimeout('coaster_enable_geolocation()',10000)
// 		  }
// 		});
// 	}

// 	var coaster_update_locator = function() {
// 		$.ajax({
// 		  url: '/locator',
// 		  data: { },
// 		  success: function(data) {
// 		  	$('#locator-wrapper').html(data).addClass('loaded');
// 		  }
// 		});
// 	}

// 	var coaster_error = function(e) {
// 		$('.lcontent').append('<p class="error">An error occurred mapping your geolocation.<br /><br />' + e + '	</p>');
// 	}


// $(function() {
// 	var t = setTimeout('coaster_enable_geolocation()',10000)
// });