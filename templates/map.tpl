{% extends "base.tpl" %}

{% block content_area %}
    {% lib "js/map.js" %}

    <div class="content">

        <img style="display:none" id="avatar" src="{% image_url m.acl.user.depiction lossless width=50 %}" />
        
        <div id="current-location">
            {% include "_current_location.tpl" %}
        </div>

        <div id="map" style="width: 100%; height: 600px;"></div>

        {% for id in m.search[{query cat='location'}] %}
            <div class="location" data-lon="{{ id.location_lng }}" data-lat="{{ id.location_lat }}" data-title="{{ id.title }}"></div>
        {% endfor %}

        {% wire name="geo_check" postback={geo_check} delegate=`nakednoord` %}

    </div>
    
{% endblock %}
