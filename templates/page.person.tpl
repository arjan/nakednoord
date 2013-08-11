{% extends "page.tpl" %}


{% block content %}
    <h1>Hi, {{ id.title }}!</h1>

    {% if not id.o.depiction %}
        {% include "_face_upload.tpl" %}

    {% else %}

        <div class="well">
            {% button id="change-avatar" class="btn btn-primary" text="Pas je outfit aan" icon="edit" action={dialog_open title="Pas je outfit aan" template="_dialog_change_outfit.tpl"} %}

            {% button id="user-avatar" class="btn" text="Vervang avatar..." icon="edit" action={dialog_open width=400 title="Upload je avatar" template="_face_upload.tpl"} %}
        </div>
        
        {% include "_user_avatar.tpl" %}

        <p>
            <br /><br />
            <a href="/whereami" class="btn btn-primary btn-large">Go to the map to start the game!</a>
        </p>
    
    {% endif %}


{% endblock %}

