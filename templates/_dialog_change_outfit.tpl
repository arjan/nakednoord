{% if m.acl.user.o.has_garment %}

{% wire type="submit" id="frm" postback={change_outfit} delegate=`nakednoord` %}
<form action="postback" method="post" id="frm">
    {% with m.acl.user.o.is_wearing|make_list as is_wearing %}
        {% for cat, items in m.notifier.first.grouped_garments %}
            <h2>{{ cat.title }}</h2>
            {% for id in items %}
                <div class="controls">
                    <label class="radio">
                        <input type="radio" name="c_{{ cat.id }}" value="{{ id }}" {% if id|member:is_wearing %}checked="checked"{% endif %}/>
                        {{ id.title }}
                    </label>
                    
                </div>
            {% endfor %}
        {% endfor %}
    {% endwith %}

    {% button text="Save outfit" class="btn btn-primary" %}
</form>

{% else %}
    <p>Het lijkt erop alsof je nog geen kledingstukken hebt verzameld…!</p>
{% endif %}

        
