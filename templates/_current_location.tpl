{% if not id or not ok %}

    <p class="alert alert-error">Je moet dichter naar een lokatie toe gaan!</p>
    
{% else %}

    <div class="well">
        <p class="alert alert-info">Je bent vlak bij {{ id.title }}!</p>
        {% button class="btn btn-primary btn-large" text="Bekijk informatie over "|append:id.title
            action={dialog_open title=id.title width="90%"
                template="_dialog_location.tpl" id=id}
        %}
    </div>
    
{% endif %}



