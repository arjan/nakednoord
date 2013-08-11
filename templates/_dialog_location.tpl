<p>
    <strong>{{ id.summary }}</strong>
</p>

{{ id.body|show_media }}


{% with m.notifier.first[{available_garments id=id}] as my_garments, other_garments %}

    {% if my_garments %}
        <h2>Dit heb je nu aan:</h2>
        <ul class="thumbnails">
            {% for id in my_garments %}
                <li class="span2">
                    <a href="#" class="thumbnail">
                        {% image id width=200 title=id.title %}
                        {% button class="btn btn-mini" text="Ik ben uitgekeken op dit kledingstuk" icon="icon-remove"
                            postback={remove_garment id=id} delegate=`nakednoord` %}
                    </a>
                </li>
            {% endfor %}
        </ul>
        
    {% endif %}

    {% if other_garments %}
        <h2>{% if my_garments %}Overige b{% else %}B{% endif %}eschikbare kledingstukken:</h2>

        <ul class="thumbnails">
            {% for id in other_garments %}
                <li class="span2">
                    <a href="#" class="thumbnail">
                        {% image id width=200 title=id.title %}
                        {% button class="btn btn-mini" text="Kies dit kledingstuk" icon="icon-ok"
                            postback={add_garment id=id} delegate=`nakednoord` %}
                    </a>
                </li>
            {% endfor %}
        </ul>
    {% endif %}
    
{% endwith %}


