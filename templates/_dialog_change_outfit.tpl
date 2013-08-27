{% if m.acl.user.o.has_garment %}

    {% wire type="submit" id="frm" postback={change_outfit from_person_page=from_person_page} delegate=`nakednoord` %}
    <form action="postback" method="post" id="frm">
        {% with m.acl.user.o.is_wearing|make_list as is_wearing %}
            <table width="100%" class="outfit">
                {% for r in m.notifier.first.grouped_garments|chunk:2 %}
                    <tr>
                        {% for cat, items in r %}
                            <td width="50%">
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
                        </td>
                    {% endfor %}
                </tr>
            {% endfor %}
        </table>
        {% endwith %}

        {% button text="Outfit opslaan" class="btn btn-primary" %}
    </form>

{% else %}
    <p>Het lijkt erop alsof je nog geen kledingstukken hebt verzameld… <a href="/whereami">Ga naar de kaart</a> om daarmee te beginnen!</p>
{% endif %}

{% button id="user-avatar" class="btn" text="Ander gezicht" icon="edit" action={dialog_open title="Upload je avatar" template="_face_upload.tpl"} %}
