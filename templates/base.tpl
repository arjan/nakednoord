{% overrules %}

{% block html_head_extra %}
    <link href='http://fonts.googleapis.com/css?family=Loved+by+the+King' rel='stylesheet' type='text/css' />

    {% javascript %}
        function hideURLbar() {
	    window.scrollTo(0, 1);
        }
        addEventListener("load", function() {
        setTimeout(hideURLbar, 0);
        }, false);
    {% endjavascript %}

    <meta name=apple-mobile-web-app-capable content=yes />
    <meta name=apple-mobile-web-app-status-bar-style content=black />

{% endblock %}
