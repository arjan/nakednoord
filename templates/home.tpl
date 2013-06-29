{% extends "base.tpl" %}

{% block title %}{{ m.site.title }}{% endblock %}

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

        <h1>Welkom bij de Naakte Noorderlingen!</h1>

        <p>
            Discover <em>Amsterdam Noord</em> by visiting historical locations and learning about the history of the city.
        </p>

        <p>
            At the same time, dress up your avatar with the historical garments you find along the way!
        </p>
        
        <p class="alert alert-info">You need to sign in to start.</p>

        <p>
            <a href="{% url facebook_authorize %}"><img src="/lib/images/fb-login-button.png" width="154" height="22" alt="Facebook login button" /></a>
        </p>
        
    {% endif %}
{% endblock %}
