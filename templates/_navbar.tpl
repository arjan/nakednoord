{# navbar for phone+ #}
<nav class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <!-- .btn-navbar is used as the toggle for collapsed navbar content -->
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>

            
            <a class="brand" href="/">
                {% if m.acl.user %}<img id="avatar" src="{% image_url m.acl.user.depiction width=32 lossless %}" style="height:20px" />{% endif %}
                {{ m.config.site.title.value }}
            </a>
                
                <div class="nav-collapse">
                    <ul class="nav">
                        {% if m.acl.user %}
                            <li>
                                <a href="{{ m.acl.user.page_url }}">Your avatar</a>
                            </li>
                            <li>
                                <a href="/whereami">Where am I?</a>
                            </li>                                    
                        {% else %}
                            <li>
                                <a id="{{ #fb_logon }}" href="#facebook"><img src="/lib/images/fb-login-button.png" width="154" height="22" alt="Facebook login button" /></a>

                                {% wire id=#fb_logon 
	                                action={mask target=mask_target|default:"logon_outer" message="Waiting for Facebook …"}
	                                postback={logon_redirect ready_page=page user_id=user_id}
	                                delegate=`mod_facebook`
                                %}
                            </li>
                        {% endif %}
                    </ul>
			        {% menu menu_id=menu_id id=id maxdepth=2 %}
                </div>
            </div>
        </div>
    </nav>
