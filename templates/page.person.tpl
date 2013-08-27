{% extends "page.tpl" %}


{% block content %}
    

    {% if not id.o.depiction %}
        {% include "_face_upload.tpl" first_time %}

    {% else %}

        <div class="person-top">

            <div class="controls pull-right">

                {% button id="change-avatar" class="btn btn-primary" text="Pas je outfit aan" icon="edit" action={dialog_open title="Pas je outfit aan" template="_dialog_change_outfit.tpl"} style="margin-bottom: 10px" %}<br/>
                

            </div>
            
            <h1>Hoi {{ id.name_first }}!</h1>
            
        </div>
        
        <p class="font">Zo zie je er nu uit:</p>

        {% include "_user_avatar.tpl" with_arrow %}
        
    {% endif %}


{% endblock %}

