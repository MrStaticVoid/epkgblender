%%%
%%% epkgblender_logout.erl
%%% Copyright (C) 2011 James Lee
%%% 
%%% This program is free software: you can redistribute it and/or modify
%%% it under the terms of the GNU General Public License as published by
%%% the Free Software Foundation, either version 3 of the License, or
%%% (at your option) any later version.
%%%
%%% This program is distributed in the hope that it will be useful,
%%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%% GNU General Public License for more details.
%%%
%%% You should have received a copy of the GNU General Public License
%%% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%%%

-module(epkgblender_logout).
-compile(export_all).

main() ->
    case wf:user() of
        undefined ->
            ok;
        User ->
            RememberMeSeries = case wf:cookie(remember_me_token) of
                "" -> "";
                Token -> hd(string:tokens(Token, ":"))
            end,
            epkgblender_user_server:logout(User, RememberMeSeries),
            wf:cookie(remember_me_token, "", "/", 0),
            wf:logout()
    end,
    wf:redirect("/").
