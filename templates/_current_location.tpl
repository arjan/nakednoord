{% if not id or not ok %}

    <p class="alert alert-error">Je moet dichter naar een lokatie toe gaan!</p>
    
{% else %}

    <div class="location-top">
        {% button class="btn btn-primary btn-large" text="Je bent vlak bij "|append:id.title|append:"!"
            action={dialog_open title=id.title width="90%"
                template="_dialog_location.tpl" id=id}
        %}
    </div>
    
{% endif %}



