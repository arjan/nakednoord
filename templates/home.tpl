{% extends "base.tpl" %}

{% block title %}{{ m.site.title }}{% endblock %}

{% block content %}
    {% if m.acl.user %}
        {% javascript %}
            document.location.href = '/whereami';
        {% endjavascript %}
    {% else %}

        <h1>Welcome to Naked Noord!</h1>
        <p>You need to sign in to start.</p>

        <p>
            <a href="{% url facebook_authorize %}"><img src="/lib/images/fb-login-button.png" width="154" height="22" alt="Facebook login button" /></a>
        </p>
        
    {% endif %}
{% endblock %}
