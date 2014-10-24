<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <title>GLobal Wish List Maps</title>
        <link rel="stylesheet" type="text/css" href="css/main.css" />
        <meta charset="utf-8">
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script> 
        <script type="text/javascript">
            var map;
            var initialLocation = new google.maps.LatLng(34.411942,-119.688851); 
            function init() {
                var mapOptions = { 
                    zoom: 12,
                    center: initialLocation,
                    mapTypeId: google.maps.MapTypeId.HYBRID
                };
                map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
                var marker = new google.maps.Marker({
                    position: initialLocation, 
                    map: map
                });
                google.maps.event.addListener(map, 'click', function(event) {
                    placeMarker(event.latLng);
                });
            }
            function placeMarker(location) {
                var marker = new google.maps.Marker({
                    position: location, 
                    map: map
                });
                map.setCenter(location);
            }
        </script>
    </head>
    <body  onload="init()"> 
        <h1>Global Wish List Maps</h1>
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
     </table>
     <br/><br/>
     <input type="submit" value="Add New"/>
    </form>
</div> 
    </body>
</html>