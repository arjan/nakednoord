{% extends "base.tpl" %}

{% block content_area %}
    {% lib "js/openlayers/OpenLayers.js" "js/map.js" %}

    <div class="content">

        <div id="current-location">
            {% include "_current_location.tpl" %}
        </div>

        {# Experimental, needs better parametrization (like resource id and div size) #}
        <div id="map" style="width: 100%; height: 600px;"></div>


        {% for id in m.search[{query cat='location'}] %}
            <div class="location" data-lon="{{ id.location_lng }}" data-lat="{{ id.location_lat }}" data-title="{{ id.title }}"></div>
        {% endfor %}

        {% wire name="geo_check" postback={geo_check} delegate=`nakednoord` %}
    </div>
    
{% endblock %}
