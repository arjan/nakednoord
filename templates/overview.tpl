{% extends "base.tpl" %}

{% block page_class %}overview{% endblock %}

{% block navbar %}{% endblock %}

{% block content %}

    <ul class="thumbnails">
        {% for id in m.search[{query cat='person' sort="-modified" pagelen=100}] %}
            <li class="span4">
                {% include "_user_avatar.tpl" id=id class="small" %}
                <p class="person-title">{{ id.title }}</p>
            </li>
        {% endfor %}
    </ul>        

    {% javascript %}
        setTimeout(function() { document.location.reload(); }, 60*1000);
    {% endjavascript %}
    
{% endblock %}
