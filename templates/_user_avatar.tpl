{# The avatar of the user #}

<div class="avatar {{ class }}">
    <img src="/lib/images/basis.png" />

    {% if with_arrow %}
        <img src="/lib/images/pijltje.png" class="arrow" width="100" />
    {% endif %}

    {% image id.o.depiction.id width=300 class="face" upscale lossless %}

    {% for id in id.o.is_wearing %}
        {% image id lossless class=id.category.name|append:" garment" %}
    {% endfor %}

</div>

