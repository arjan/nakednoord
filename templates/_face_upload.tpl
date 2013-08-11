{% wire id="upload" type="submit" postback={face_upload} delegate=`nakednoord` %}
<form id="upload" action="postback" method="post">

    <p>Upload hier een plaatje van je gezicht, voor je avatar.
        Je gezicht moet herkenbaar zijn.
    </p>
    
    <input type="file" name="file" onchange="$('#click').click();" />
    <button style="display:none" id="click">Go</button>
</form>
