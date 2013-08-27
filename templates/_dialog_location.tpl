<p>
    <strong>{{ id.summary }}</strong>
</p>

{{ id.body|show_media }}

{% with m.notifier.first[{available_garments id=id}] as my_garments, other_garments %}

    {% if my_garments %}
        <h2>Dit kledingstuk heb je van deze lokatie:</h2>
        <ul class="thumbnails">
            {% for id in my_garments %}
                <li class="span2">
                    <a href="#" class="thumbnail">
                        {% image id.o.depiction|last width=170 title=id.title %}
                        {% button class="btn btn-mini" text="Ik wil deze niet meer"
                            postback={remove_garment id=id} delegate=`nakednoord` %}
                    </a>
                </li>
            {% endfor %}
        </ul>
        
    {% endif %}

    {% if other_garments %}
        <h2>{% if my_garments %}Overige {% else %}Beschikbare{% endif %} kledingstukken van deze plek:</h2>

            <ul class="thumbnails">
                {% for id in other_garments %}
                    <li class="span2">
                        {% if my_garments %}
                            {% image id.o.depiction|last width=170 title=id.title %}
                        {% else %}
                            <a href="#" class="thumbnail" id="{{ #click.id }}">
                                {% image id.o.depiction|last width=170 title=id.title %}
                                {% button class="btn btn-mini" text="Kies dit kledingstuk"
                                    postback={add_garment id=id} delegate=`nakednoord` %}
                            </a>
                        {% endif %}
                    </li>
                {% endfor %}
            </ul>
        {% endif %}
        
    {% endwith %}


