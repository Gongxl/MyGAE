<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Welcome iMoney</title>
        <link rel="stylesheet" type="text/css" href="css/main.css" />
        <meta charset="utf-8">
        <script src="https://maps.googleapis.com/maps/api/js?signed_in=true&v=3.exp"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
        <script>
           $(function() {
               $( "#datepicker" ).datepicker();
            });
        </script>
    <script>
        var map;
        var geocoder;
        function initialize() {
          var mapOptions = {
            zoom: 12
          };
          map = new google.maps.Map(document.getElementById('map_canvas'),
              mapOptions);
          geocoder = new google.maps.Geocoder(); 
          // Try HTML5 geolocation
          if(navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
              var pos = new google.maps.LatLng(position.coords.latitude,
                                               position.coords.longitude);

              var infowindow = new google.maps.InfoWindow({
                map: map,
                position: pos,
                content: 'You are here!'
              });

              google.maps.event.addListener(map, 'click', function(event) {
                  placeMarker(event.latLng);
               });
              map.setCenter(pos);
            }, function() {
              handleNoGeolocation(true);
            });
          } else {
            // Browser doesn't support Geolocation
            handleNoGeolocation(false);
          }
        }

        function handleNoGeolocation(errorFlag) {
          if (errorFlag) {
            var content = 'Error: The Geolocation service failed.';
          } else {
            var content = 'Error: Your browser doesn\'t support geolocation.';
          }

          var options = {
            map: map,
            position: new google.maps.LatLng(34.414899, -119.8431197),
            content: content
          };

          var infowindow = new google.maps.InfoWindow(options);
          
          var marker = new google.maps.Marker({ 
              position: options.position, 
              map: map
          });
          
          map.setCenter(options.position);
          
        }

        function placeMarker(location) {
            var marker = new google.maps.Marker({
            position: location,
            map: map
        });
            $("#longitude").val(location.lng());  
            $("#latitude").val(location.lat());
            geocoder.geocode( { 'latLng': location}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    $("#address").val(results[0].formatted_address);
                } else {
                    alert("Geocode was not successful for the following reason: " + status);
                }
            });
            map.setCenter(location);
    }
        google.maps.event.addDomListener(window, 'load', initialize);
        </script>
    </head>
    <body  onload="init()"> 
        <h1>I spend money here!</h1>
        <div id="map_canvas"></div>
        <div id="marker_data">
        <form id="createForm" action="/new" method="post" accept-charset="utf-8">
            <table>
                <tr>
                    <td>Title</td>
                    <td><input type="text" name="title" id="title" size="66"/></td>
                </tr>
                <tr>
                    <td>Description</td>
                    <td><textarea rows="4" cols="50" name="description" id="description"></textarea>
                </tr>
                <tr>
                    <td>Latitude</td>
                    <td><input type="text" name="latitude" id="latitude" size="66" /></td>
                </tr>
                <tr>
                    <td>Longitude</td>
                    <td><input type="text" name="longitude" id="longitude" size="66" /></td>
                </tr>
                <tr>
                    <td>Address</td>
                    <td><input type="text" name="address" id="address" size="66" /></td>
                </tr>
                 <tr>
                    <td>Date</td>
                    <td><input type="text" name="date" id="datepicker" size="66" /></td>
                </tr>
            </table><br/><br/>
            <input type="submit" value="Save"/>
        </form>
    </div>

    </body>
</html>