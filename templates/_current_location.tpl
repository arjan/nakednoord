{% if not id or not ok %}

    <p class="alert alert-error">Neem achter Amsterdam Centraal Station de pont naar Noord om dichterbij de locaties te komen!</p>
    
{% else %}

    <div class="location-top">
        {% button class="btn btn-primary btn-large" text="Je bent vlak bij "|append:id.title|append:"!"
            action={dialog_open title=id.title width="90%"
                template="_dialog_location.tpl" id=id}
        %}
    </div>
    
{% endif %}



