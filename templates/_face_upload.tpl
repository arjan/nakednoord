{% wire id="upload" type="submit" postback={face_upload} delegate=`nakednoord` %}
<form id="upload" action="postback" method="post">
    <h2>Upload a picture of yourself!</h2>
    <p>Your face has to recognizable. Choose a picture with just one face, otherwise it won't work.</p>
    <input type="file" name="file" onchange="$('#click').click();" />
    <button style="display:none" id="click">Go</button>
</form>
