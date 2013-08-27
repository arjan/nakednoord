{% extends "page.tpl" %}


{% block content %}
    

    {% if not id.o.depiction %}
        {% include "_face_upload.tpl" first_time %}

    {% else %}

        <div class="person-top">

            <div class="controls pull-right">
            {% if m.acl.user.o.has_garment %}
                {% button id="change-avatar" class="btn btn-primary" text="Pas je outfit aan" icon="edit" action={dialog_open title="Pas je outfit aan" template="_dialog_change_outfit.tpl"} style="margin-bottom: 10px" %}<br/>
        {% endif %}
        
        {% button id="user-avatar" class="btn" text="Ander gezicht!" icon="edit" action={dialog_open title="Upload je avatar" template="_face_upload.tpl"} %}

    </div>
            <h1>Hoi, {{ id.title }}!</h1>
        
        </div>

        
        <p>Zo zie je er nu uit:</p>

        {% include "_user_avatar.tpl" with_arrow %}
        
    {% endif %}


{% endblock %}

