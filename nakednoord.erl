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
-mod_schema(1).

-include_lib("zotonic.hrl").


-export([
         init/1,
         observe_signup_url/2,
         observe_signup_done/2,
         observe_logon_ready_page/2,
         observe_custom_pivot/2,
         manage_schema/2,
         
         observe_available_garments/2,
         observe_grouped_garments/2,
         
         event/2
        ]).


%%====================================================================
%% support functions go here
%%====================================================================

init(Context) ->
    z_pivot_rsc:define_custom_pivot(?MODULE, [{lon, "float"}, {lat, "float"}], Context),
    ok.

%% return existing and available garments for this location for the user.
observe_available_garments({available_garments, [{id, Id}]}, Context) ->
    User = z_acl:user(Context),

    MyGarments = sets:from_list(m_edge:objects(User, has_garment, Context)),
    
    LocationGarments = sets:from_list(m_edge:objects(Id, has_garment, Context)),
    
    {sets:to_list(sets:intersection(MyGarments, LocationGarments)),
     sets:to_list(sets:subtract(LocationGarments, MyGarments))
    }.

observe_grouped_garments(grouped_garments, Context) ->
    User = z_acl:user(Context),

    lists:foldl(fun(Id, Acc) ->
                        Cat = m_rsc:p(Id, category_id, Context),
                        case proplists:get_value(Cat, Acc) of
                            undefined ->
                                [{Cat, [Id]} | Acc];
                            List ->
                                z_utils:prop_replace(Cat, [Id|List], Acc)
                        end
                end,
                [],
                m_edge:objects(User, has_garment, Context)).



manage_schema(install, _) ->
    #datamodel{
               categories=[
                           {garment, undefined, [{title, <<"Garment">>}]},
                           
                           {accessory, garment, [{title, <<"Accessoires">>}]},
                           {head, garment, [{title, <<"Hoofdbedekking">>}]},
                           {body, garment, [{title, <<"Bovenkleding">>}]},
                           {trousers, garment, [{title, <<"Broeken en zo">>}]},
                           {shoes, garment, [{title, <<"Schoeisel">>}]}
                          ],
               predicates=[
                           {has_garment,
                            [{title, <<"Possesses garment">>}],
                            [{person, garment},
                             {location, garment}]
                           },
                           {is_wearing,
                            [{title, <<"Wearing garment">>}],
                            [{person, garment}]
                           }
                          ]
              }.


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
    {ok, _UserId} = mod_signup:signup_existing(undefined, Props, SignupProps, false, Context),
    {ok, "/facebook/authorize"}. %% do the dance again to go with the flow


%% @doc Check if a module wants to redirect to the signup form.  Returns either {ok, Location} or undefined.
observe_signup_done(#signup_done{id=UserId, props=Props}, Context) ->
    {ok, ContextLogon} = z_auth:logon(UserId, Context),
    m_rsc:update(UserId, Props, ContextLogon),
    lager:warning("123: ~p", [123]),
    lager:warning("Props: ~p", [Props]),
    lager:warning("UserId: ~p", [UserId]),
    {ok, m_rsc:p(z_acl:user(ContextLogon), page_url, ContextLogon)}.

observe_logon_ready_page(#logon_ready_page{request_page=[]}, Context) ->
    lager:warning("logon_ready: ~p", [xx]),
    case z_auth:is_auth(Context) of
        true -> m_rsc:p(z_acl:user(Context), page_url, Context);
        false -> []
    end;
observe_logon_ready_page(#logon_ready_page{request_page=Url}, _Context) ->
    Url.


event(#submit{message={face_upload, _}}, Context) ->

    case z_context:get_q("file", Context) of
        #upload{tmpfile=TmpName} ->
            case os:cmd("/usr/local/bin/faceservice " ++ TmpName) of
                Cmd = "mogrify " ++ _ ->
                    os:cmd(Cmd),
                    lager:warning("TmpName: ~p", [TmpName]),
                    {ok, MediaId} = m_media:insert_file(head_mask(TmpName, Context), Context),
                    m_edge:replace(z_acl:user(Context), depiction, [MediaId], Context),
                    z_render:wire([{reload, []}], Context);
                "nofaces\n" ++ _ ->
                    z_render:growl("Hmm, het lukt me niet hier een gezicht in te herkennen!", Context);
                _Other ->
                    z_render:growl("Dit plaatje is onbruikbaar... :-/", Context)
            end;
        _ ->
            z_render:growl("Kies a.u.b. een bestand!", Context)
    end;

event(#postback{message={geo_check, _}}, Context) ->
    Lon = z_convert:to_float(z_context:get_q("lon", Context)),
    Lat = z_convert:to_float(z_context:get_q("lat", Context)),

    LocationCat = m_rsc:name_to_id_check(location, Context),

    Query = "SELECT id, (point($1, $2) OPERATOR(public.<@>) point(p.lon, p.lat))/1.60934 as dist FROM rsc JOIN pivot_nakednoord p USING (id) WHERE category_id=$3 order by dist LIMIT 1",
    %%Query = "SELECT id, sqrt(($1-p.lon)*($1-p.lon) + ($2-p.lat)*($2-p.lat)) as dist FROM rsc JOIN pivot_nakednoord p USING (id) WHERE category_id=$3 order by dist LIMIT 1",
    
    [{Id, Dist}] = z_db:q(Query, [Lon, Lat, LocationCat], Context),
    
%    lager:warning("Dist: ~p", [Dist]),
    Vars = [{id, Id},
            {dist, Dist},
%            {ok, true}],
            {ok, Dist < 0.5}], %% warning - hardcoded nr :p
    Html = z_template:render("_current_location.tpl", Vars, Context),
    z_render:update("current-location", Html, Context);


event(#postback{message={remove_garment, [{id, Id}, {location_id, LocationId}]}}, Context) ->
    User = z_acl:user(Context),
    m_edge:delete(User, has_garment, Id, Context),
    m_edge:delete(User, is_wearing, Id, Context),
    z_render:update(" .modal-body", z_template:render("_dialog_location.tpl", [{id, LocationId}], Context), Context);
%    z_render:dialog_close(Context);

event(#postback{message={add_garment, [{id, Id}]}}, Context) ->
    User = z_acl:user(Context),
    m_edge:insert(User, has_garment, Id, Context),
    z_render:dialog("Pas nu je outfit aan", "_dialog_change_outfit.tpl", [], Context);

event(#submit{message={change_outfit, [{from_person_page, F}]}}, Context) ->
    Wearing = lists:foldl(
                fun ({"c_" ++ _, []}, Acc) ->
                        Acc;
                    ({"c_" ++ _, R}, Acc) ->
                        [list_to_integer(R) | Acc];
                    (_X, Acc) -> Acc
               end,
               [],
                z_context:get_q_all(Context)),
    lager:warning("Wearing: ~p", [Wearing]),
    %% update outfit
    m_edge:replace(z_acl:user(Context), is_wearing, Wearing, Context),
    case F of
        true ->
            z_render:wire([{reload, []}], Context);
        _ ->
            dialog_view_avatar(Context)
    end.


dim(File) ->
    [_, _, S | _] = string:tokens(os:cmd("identify " ++ File), " "),
    [W,H] = string:tokens(S, "x"),
    {z_convert:to_integer(W), z_convert:to_integer(H)}.

head_mask(TmpFile, Context) ->
    Mask = z_path:site_dir(Context) ++ "/mask.png",
    X=os:cmd("convert " ++ TmpFile ++ " -resize 600x600 " ++ Mask ++ " -resize 600x600 -alpha Set -compose DstOut -composite -auto-level /tmp/out.png"),
    "/tmp/out.png".


dialog_view_avatar(Context) ->
    z_render:dialog("Zo zie je er nu uit!", "_dialog_user_avatar.tpl", [{id, z_acl:user(Context)}, {class, "small"}], Context).
