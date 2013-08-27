{% if m.acl.user and m.acl.user.o.depiction %}

    <div class="container-fluid navarea">
		<div class="row-fluid">
			<div class="span12">
                {% if zotonic_dispatch == "whereami" %}
                    <a href="{{ m.acl.user.page_url }}" class="btn btn-nav">Bekijk je avatar</a>
                {% else %}
                    <a href="/whereami" class="btn btn-nav">Ga naar de kaart</a>
                {% endif %}
            </div>
        </div>
    </div>
{% endif %}
