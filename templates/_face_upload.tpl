{% wire id="upload" type="submit" postback={face_upload} delegate=`nakednoord` %}
<form id="upload" action="postback" method="post">

    {% if first_time %}

        <h2>Hoi {{ m.acl.user.name_first }}!</h2>

        <p>Om te beginnen, upload hier een plaatje van je gezicht, voor op
            je avatar.  Je gezicht moet herkenbaar zijn.  </p>
        
    {% else %}

        <p>Upload hier een nieuw plaatje van je gezicht, voor op
            je avatar.  Je gezicht moet herkenbaar zijn.  </p>
        
    {% endif %}
    
    <input type="file" name="file" onchange="$('#click').click();" />
    <div>
        <button class="btn btn-primary" id="click">Upload</button>
    </div>
</form>
