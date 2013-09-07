(function() {

    var map;
    

    function initialize(g) {
        var mapOptions = {
            zoom: 15,
            center: new google.maps.LatLng(52.381182, 4.914827),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        $("#map").css("height", $("body").height()-260);
        
        map = new google.maps.Map(document.getElementById('map'), mapOptions);

        var markerImage = '/lib/images/marker.png';
        
        $("div.location").each(function() {
            var loc = new google.maps.LatLng(parseFloat($(this).attr("data-lat")), parseFloat($(this).attr("data-lon")));
            new google.maps.Marker({
                position: loc,
                map: map,
                icon: {url: markerImage, scaledSize: new google.maps.Size(30, 32)}
            });
        });
    }
    google.maps.event.addDomListener(window, 'load', initialize);

    var my_marker;
    function updatePosition(g) {
        var loc = new google.maps.LatLng(g.coords.latitude, g.coords.longitude);
        //console.log('upd', loc);

        if (!my_marker) {
            my_marker = new google.maps.Marker({
                position: loc,
                map: map,
                icon: {url: $("#avatar").attr("src"), scaledSize: new google.maps.Size(40, 40)}
            });
        } else {
            my_marker.setPosition(loc);
        }
        map.setCenter(loc);
        z_event("geo_check", {lon: g.coords.longitude, lat: g.coords.latitude});
    }

    var options = {
        enableHighAccuracy: true,
        timeout: 10000,
        maximumAge: 0
    };

    function locationError() {
        alert("We konden je locatie niet bepalen! Staat je GPS aan? Zorg ervoor dat je instellingen goed zijn en refresh deze pagina daarna.");
    }

    try {
        navigator.geolocation.watchPosition(updatePosition, locationError, options);
    } catch (e) {
        locationError();
    }
    
    
})();
