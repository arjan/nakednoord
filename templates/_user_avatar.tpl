{# The avatar of the user #}

<div class="avatar">
    <img src="/lib/images/basis.png" />

    {% image id.o.depiction.id width=300 class="face" lossless %}

    {% for id in id.o.is_wearing %}
        {% image id lossless class=id.category.name %}
    {% endfor %}

</div>

