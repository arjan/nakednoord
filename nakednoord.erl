%% @author Arjan Scherpenisse
%% @copyright 2013 Arjan Scherpenisse
%% Generated on 2013-06-29
%% @doc This site was based on the 'empty' skeleton.

%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(nakednoord).
-author("Arjan Scherpenisse").

-mod_title("nakednoord zotonic site").
-mod_description("An empty Zotonic site, to base your site on.").
-mod_prio(10).

-include_lib("zotonic.hrl").


-export([
         init/1,
         observe_signup_url/2,
         observe_signup_done/2,
         observe_logon_ready_page/2,
         observe_custom_pivot/2,
         event/2
        ]).


%%====================================================================
%% support functions go here
%%====================================================================

init(Context) ->
    z_pivot_rsc:define_custom_pivot(?MODULE, [{lon, "float"}, {lat, "float"}], Context),
    ok.


observe_custom_pivot({custom_pivot, Id}, Context) ->
    case m_rsc:is_a(Id, location, Context) of
        false ->
            none;
        true ->
            lager:warning("xx: ~p", [xx]),
            {?MODULE, [
                       {lon, z_convert:to_float(m_rsc:p(Id, location_lng, Context))},
                       {lat, z_convert:to_float(m_rsc:p(Id, location_lat, Context))}
                      ]}
    end.


observe_signup_url(#signup_url{props=Props, signup_props=SignupProps}, Context) ->
    mod_signup:signup_existing(undefined, Props, SignupProps, false, Context),
    {ok, "/"}.


%% @doc Check if a module wants to redirect to the signup form.  Returns either {ok, Location} or undefined.
observe_signup_done(Msg, Context) ->
    ok.

observe_logon_ready_page(#logon_ready_page{request_page=[]}, Context) ->
    case z_auth:is_auth(Context) of
        true -> m_rsc:p(z_acl:user(Context), page_url, Context);
        false -> []
    end;
observe_logon_ready_page(#logon_ready_page{request_page=Url}, _Context) ->
    Url.


event(#submit{message={face_upload, _}}, Context) ->

    F = z_context:get_q("file", Context),
    TmpName = F#upload.tmpfile,
    lager:warning("F: ~p", [TmpName]),

    case os:cmd("/usr/local/bin/faceservice " ++ TmpName) of
        Cmd = "mogrify " ++ _ ->
            os:cmd(Cmd),
            lager:warning("TmpName: ~p", [TmpName]),
            {ok, MediaId} = m_media:insert_file(head_mask(TmpName, Context), Context),
            m_edge:replace(z_acl:user(Context), depiction, [MediaId], Context),
            z_render:wire([{reload, []}], Context);
        "nofaces\n" ->
            z_render:growl("Sorry, we could not recognize a face in this image...sorry!", Context);
        Other ->
            z_render:growl("Sorry, this image cannot be used: " ++ Other, Context)
    end;

event(#postback{message={geo_check, _}}, Context) ->
    Lon = z_convert:to_float(z_context:get_q("lon", Context)),
    Lat = z_convert:to_float(z_context:get_q("lat", Context)),

    LocationCat = m_rsc:name_to_id_check(location, Context),
    Query = "SELECT id, (point($1, $2) OPERATOR(public.<@>) point(p.lon, p.lat))/1.60934 as dist FROM rsc JOIN pivot_nakednoord p USING (id) WHERE category_id=$3 order by dist LIMIT 1",
    [{Id, Dist}] = z_db:q(Query, [Lon, Lat, LocationCat], Context),
    Vars = [{id, Id},
            {dist, Dist},
            {ok, Dist < 0.5}],
    Html = z_template:render("_current_location.tpl", Vars, Context),
    z_render:update("current-location", Html, Context).

dim(File) ->
    [_, _, S | _] = string:tokens(os:cmd("identify " ++ File), " "),
    [W,H] = string:tokens(S, "x"),
    {z_convert:to_integer(W), z_convert:to_integer(H)}.

head_mask(TmpFile, Context) ->
    Mask = z_path:site_dir(Context) ++ "/mask.png",
    X=os:cmd("convert " ++ TmpFile ++ " -resize 600x600 " ++ Mask ++ " -resize 600x600 -alpha Set -compose DstOut -composite -auto-level /tmp/out.png"),
    "/tmp/out.png".

