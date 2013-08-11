{% if m.acl.user.o.has_garment %}

{% wire type="submit" id="frm" postback={change_outfit} delegate=`nakednoord` %}
<form action="postback" method="post" id="frm">
    {% with m.acl.user.o.is_wearing|make_list as is_wearing %}
        {% for cat, items in m.notifier.first.grouped_garments %}
            <h2>{{ cat.title }}</h2>
            <div class="controls">
                {% for id in items %}
                    <label class="radio">
                        <input type="radio" name="c_{{ cat.id }}" value="{{ id }}" {% if id|member:is_wearing %}checked="checked"{% endif %}/>
                        {{ id.title }}
                    </label>
                {% endfor %}

                <label class="radio">
                    <input type="radio" name="c_{{ cat.id }}" value="" />
                    <em>Niets</em>
                </label>
            </div>
        {% endfor %}
    {% endwith %}

    {% button text="Outfit opslaan" class="btn btn-primary" %}
</form>

{% else %}
    <p>Het lijkt erop alsof je nog geen kledingstukken hebt verzameld…!</p>
{% endif %}

        
