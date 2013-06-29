{% extends "base.tpl" %}

{% block title %}{{ m.site.title }}{% endblock %}

{% block content %}
    {% if m.acl.user %}
        {% javascript %}
            document.location.href = '/whereami';
        {% endjavascript %}
    {% else %}
        <h1>Naked noord!</h1>
        <p>You need to sign in to start.</p>
        <a id="{{ #fb_logon }}" href="#facebook"><img src="/lib/images/fb-login-button.png" width="154" height="22" alt="Facebook login button" /></a>
        
    {% endif %}
{% endblock %}
