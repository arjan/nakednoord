{% extends "base.tpl" %}

{% block page_class %}overview{% endblock %}

{% block navbar %}{% endblock %}

{% block content %}

    <ul class="thumbnails overview">

        {% for id in m.search[{query cat='person' sort="-modified" id_exclude=1 pagelen=100}] %}
            {% with m.rsc[id].o.depiction[2] as outfit %}
                {% if outfit %}
                    <li class="span3">
                        {% image outfit width=200 lossless %}
                        <p class="person-title">{{ id.name_first|default:id.title }}</p>
                    </li>
                {% endif %}
            {% endwith %}
        {% endfor %}
        
    </ul>        

    {% javascript %}
        setTimeout(function() { document.location.reload(); }, 60*1000);
    {% endjavascript %}
    
{% endblock %}
