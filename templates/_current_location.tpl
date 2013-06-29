{% if not id or not ok %}

    <p class="alert alert-error">You need to get closer to a location</p>
    
{% else %}

    <div class="well">
        <p class="alert alert-info">You are close to {{ id.title }}!</p>
        {% button class="btn btn-primary btn-large" text="View info about "|append:id.title
            action={dialog_open title=id.title
                template="_dialog_location.tpl" id=id}
        %}
    </div>
    
{% endif %}



