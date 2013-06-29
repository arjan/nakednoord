{% extends "page.tpl" %}


{% block content %}
    <h1>Hi, {{ id.title }}!</h1>

    {% if not id.o.depiction %}
        {% include "_face_upload.tpl" %}

    {% else %}

        {% include "_user_avatar.tpl" %}

        <div class="controls">
            {% wire id="user-avatar" class="btn btn-mini" text="Replace..." icon="edit" action={dialog_open title="Face upload" template="_face_upload.tpl"} %}
        </div>

        <p>
            <br /><br />
            <a href="/whereami" class="btn btn-primary btn-large">Go to the map to start the game!</a>
        </p>
    
    {% endif %}


{% endblock %}

