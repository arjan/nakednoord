{% extends "page.tpl" %}

{% block html_head_extra %}

    {% with m.rsc[id].o.depiction[2] as outfit %}
        {% if outfit %}
            <meta property="og:image" content="{% image_url outfit use_absolute_url %}"/>
        {% endif %}
    {% endwith %}

    <meta property="og:title" content="{{ id.name_first|default:id.title }} als Naakte Noorderling"/>
    <meta property="og:url" content="{% url page id=id slug=id.slug use_absolute_url %}"/>
    <meta property="og:site_name" content="De Naakte Noorderling"/>

{% endblock %}

{% block content %}
    
    {% if id == m.acl.user %}
        {% if not id.o.depiction %}
            {% include "_face_upload.tpl" first_time %}

        {% else %}

            <div class="person-top">

                <div class="controls pull-right">

                    {% button id="change-avatar" class="btn btn-primary" text="Pas je outfit aan" icon="edit" action={dialog_open title="Pas je outfit aan" template="_dialog_change_outfit.tpl" from_person_page} style="margin-bottom: 10px" %}<br/>
                    

                </div>
                
                <h1>Hoi {{ id.name_first }}!</h1>
                
            </div>
            
            <p class="font">Zo zie je er nu uit:</p>

            {% include "_user_avatar.tpl" with_arrow %}

                <p class="pull-right">
                    <a class="btn btn-primary" href="https://www.facebook.com/sharer/sharer.php?u={% url page id=id use_absolute_url %}" target="_blank">Deel op Facebook</a>
                </p>
            
        {% endif %}

    {% else %}

        {# PUBLIC VIEW #}
        {% with m.rsc[id].o.depiction[2] as outfit %}
            {% if outfit %}
                <p class="pull-right">
                    <a class="btn btn-primary" href="https://www.facebook.com/sharer/sharer.php?u={% url page id=id use_absolute_url %}" target="_blank">Deel op Facebook</a>
                </p>
                <h2>Zo ziet {{ id.name_first }} er uit:</h2>

                
                <p>
                    {% image outfit lossless %}
                </p>
                
            {% else %}
                <h1>{{ id.name_first|default:id.title }} heeft nog geen outfit!</h1>
                <p>
                    
                </p>
            {% endif %}
        {% endwith %}

    {% endif %}    

{% endblock %}

