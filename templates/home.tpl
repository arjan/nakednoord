{% extends "base.tpl" %}

{% block title %}De Naakte Noorderling{% endblock %}

{% block content %}

    {% if m.acl.user %}
        
        {% javascript %}
            {% if m.acl.user.depiction[1] %}
                document.location.href = '/whereami';
            {% else %}
                document.location.href = '{{ m.acl.user.page_url }}';
            {% endif %}
        {% endjavascript %}
    {% else %}

        <img src="/lib/images/plaatjes.png" width="160" class="pull-right" />
        
        <h1>Ontdek de verborgen geschiedenis van Amsterdam Noord.</h1>

        <p>Met dit spel bezoek je historische locaties en leer je meer over de geschiedenis van dit stadsdeel. </p>

        <p>Onderweg vind je allerlei kleding en accessoires om je avatar aan te kleden. Share je beste outfit op Facebook!</p>

        <p class="alert alert-info">Om te spelen en te onthouden welke kleding je hebt verzameld moet je inloggen. </p>
        
        <p>
            <a class="btn btn-primary btn-large" href="{% url facebook_authorize %}">Inloggen met Facebook</a>
        </p>
        
    {% endif %}
{% endblock %}
