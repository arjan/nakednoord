{% extends "base.tpl" %}

{% block content %}

    <ul class="thumbnails">
        {% for id in m.search[{query cat='person' sort="-modified" pagelen=100}] %}
            <li class="span4">
                <a class="thumbnail">
                    {% include "_user_avatar.tpl" id=id class="small" %}
                    <p class="person-title">{{ id.title }}</p>
                </a>
            </li>
        {% endfor %}
    </ul>        

{% endblock %}
