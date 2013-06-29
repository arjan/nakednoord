<p>
    <strong>{{ id.summary }}</strong>
</p>

{{ id.body|show_media }}

<h2>This location has the following items:</h2>

{% for id in id.o.depiction %}

    {% image id width=100 class="pull-left" %}
    
{% endfor %}


