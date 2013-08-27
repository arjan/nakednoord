(function() {

    navigator.geolocation.getCurrentPosition(start);

    function start(g) {
        
        var center = [4.914827, 52.381182];
        OpenLayers.ImgPath = '/lib/images/'

        var map;

        
        function lonlat(lon, lat) {
            return new OpenLayers
                .LonLat(lon, lat)
                .transform(
                    new OpenLayers.Projection("EPSG:4326"),
                    map.getProjectionObject());
        }


        var marker;

        map = new OpenLayers.Map('map');
        var layer = new OpenLayers.Layer.OSM("OpenStreetMap");
        map.addLayer(layer);
        var markers = new OpenLayers.Layer.Markers("Markers");
        map.addLayer(markers);

        var marker_size = new OpenLayers.Size(25,25);
        var marker_offset = new OpenLayers.Pixel(-(marker_size.w/2), -marker_size.h);
        var marker_icon = new OpenLayers.Icon('/lib/images/marker.png', marker_size, marker_offset);

        var map_location = map.setCenter(lonlat(center[0], center[1]), 14);
        
        $("div.location").each(function() {
            loc = lonlat($(this).attr("data-lon"), $(this).attr("data-lat"));
            markers.addMarker(new OpenLayers.Marker(loc, new OpenLayers.Icon('/lib/images/marker.png', marker_size, marker_offset)));
            console.log(loc);

        });
        var my_marker;
        
        function updatePosition(g) {
            if (my_marker) markers.removeMarker(my_marker);
            var my_location = lonlat(g.coords.longitude, g.coords.latitude);
            my_marker = new OpenLayers.Marker(my_location, new OpenLayers.Icon($("#avatar").attr("src"), marker_size, marker_offset));
            markers.addMarker(my_marker);
            z_event("geo_check", {lon: g.coords.longitude, lat: g.coords.latitude});
        }
        
        updatePosition(g);

        //marker_icon.setOpacity(0.8);
        //markers.addMarker(new OpenLayers.Marker(map_location, marker_icon));

        window.m = my_marker;
        
        function pollLocation() {
            navigator.geolocation.getCurrentPosition(function(g) {
                updatePosition(g);
            });
        }
        
        setInterval(pollLocation, 5000);
    }
})($);
