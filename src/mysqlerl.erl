%% Modeled from ODBC
%% http://www.erlang.org/doc/apps/odbc/

-module(mysqlerl).
-author('bjc@kublai.com').

-export([test_start/0, test_msg/0]).

-export([start/0, start/1, stop/0, commit/2, commit/3,
         connect/6, disconnect/1, describe_table/2,
         describe_table/3, first/1, first/2,
         last/1, last/2, next/1, next/2, prev/1,
         prev/2, select_count/2, select_count/3,
         select/3, select/4, param_query/3, param_query/4,
         sql_query/2, sql_query/3]).

-define(CONFIG, "/Users/bjc/tmp/test-server.cfg").
-define(NOTIMPLEMENTED, {error, {not_implemented,
                                 "This function has only been stubbed "
                                 "out for reference."}}).

test_start() ->
    {ok, [{Host, Port, DB, User, Pass, Options}]} = file:consult(?CONFIG),
    mysqlerl:connect(Host, Port, DB, User, Pass, Options).

test_msg() ->
    commit(mysqlerl_connection_sup:random_child(),
           rollback, 2000).

start() ->
    start(temporary).

%% Arguments:
%%     Type = permanent | transient | temporary
%%
%% Returns:
%%     ok | {error, Reason}
start(Type) ->
    application:start(sasl),
    application:start(mysqlerl, Type).

stop() ->
    application:stop(mysqlerl).

commit(Ref, CommitMode) ->
    commit(Ref, CommitMode, infinity).

%% Arguments:
%%     Ref = connection_reference()
%%     Timeout = time_out()
%%     CommitMode = commit | rollback
%%     Reason = not_an_explicit_commit_connection |
%%              process_not_owner_of_odbc_connection |
%%              common_reason()
%%     ok | {error, Reason}
commit(Ref, commit, Timeout) ->
    mysqlerl_connection:sql_query(Ref, "COMMIT", Timeout);
commit(Ref, rollback, Timeout) ->
    mysqlerl_connection:sql_query(Ref, "ROLLBACK", Timeout).

%% Arguments:
%%     Host = string()
%%     Port = integer()
%%     Database = string()
%%     User = string()
%%     Password = string()
%%     Options = list()
%%
%% Returns:
%%     {ok, Ref} | {error, Reason}
%%     Ref = connection_reference()
connect(Host, Port, Database, User, Password, Options) ->
    mysqlerl_connection_sup:connect(Host, Port, Database,
                                    User, Password, Options).

%% Arguments:
%%     Ref = connection_reference()
%%
%% Returns:
%%     ok | {error, Reason}
disconnect(Ref) ->
    mysqlerl_connection:stop(Ref).

describe_table(Ref, Table) ->
    describe_table(Ref, Table, infinity).

%% Arguments:
%%     Ref = connection_reference()
%%     Table = string()
%%     Timeout = time_out()
%%
%% Returns:
%%     {ok, Description} | {error, Reason}
%%     Description = [{col_name(), odbc_data_type()}]
describe_table(_Ref, _Table, _Timeout) ->
    ?NOTIMPLEMENTED.

first(Ref) ->
    first(Ref, infinity).

%% Arguments:
%%     Ref = connection_reference()
%%     Timeout = time_out()
%% Returns:
%%     {selected, ColNames, Rows} | {error, Reason}
%%     Rows = rows()
first(_Ref, _Timeout) ->
    ?NOTIMPLEMENTED.

last(Ref) ->
    last(Ref, infinity).

%% Arguments:
%%     Ref = connection_reference()
%%     Timeout = time_out()
%% Returns:
%%     {selected, ColNames, Rows} | {error, Reason}
%%     Rows = rows()
last(_Ref, _Timeout) ->
    ?NOTIMPLEMENTED.

next(Ref) ->
    next(Ref, infinity).

%% Arguments:
%%     Ref = connection_reference()
%%     Timeout = time_out()
%% Returns:
%%     {selected, ColNames, Rows} | {error, Reason}
%%     Rows = rows()
next(_Ref, _Timeout) ->
    ?NOTIMPLEMENTED.

prev(Ref) ->
    prev(Ref, infinity).

%% Arguments:
%%     Ref = connection_reference()
%%     Timeout = time_out()
%% Returns:
%%     {selected, ColNames, Rows} | {error, Reason}
%%     Rows = rows()
prev(_Ref, _Timeout) ->
    ?NOTIMPLEMENTED.

select_count(Ref, SQLQuery) ->
    select_count(Ref, SQLQuery, infinity).

%% Arguments:
%%     Ref = connection_reference()
%%     SQLQuery = string()
%%     Timeout = time_out()
%% Returns:
%%     {ok, NrRows} | {error, Reason}
%%     NrRows = n_rows()
select_count(_Ref, _SQLQuery, _Timeout) ->
    ?NOTIMPLEMENTED.

select(Ref, Pos, N) ->
    select(Ref, Pos, N, infinity).

%% Arguments:
%%     Ref = connection_reference()
%%     Pos = integer()
%%     Timeout = time_out()
%% Returns:
%%     {selected, ColNames, Rows} | {error, Reason}
%%     Rows = rows()
select(_Ref, _Pos, _N, _Timeout) ->
    ?NOTIMPLEMENTED.

param_query(Ref, SQLQuery, Params) ->
    param_query(Ref, SQLQuery, Params, infinity).

%% Arguments:
%%     Ref = connection_reference()
%%     SQLQuery = string()
%%     Params = [{odbc_data_type(), [value()]}]
%%     Timeout = time_out()
%% Returns:
%%     {selected, ColNames, Rows} | {error, Reason}
%%     Rows = rows()
param_query(_Ref, _SQLQuery, _Params, _Timeout) ->
    ?NOTIMPLEMENTED.

sql_query(Ref, SQLQuery) ->
    sql_query(Ref, SQLQuery, infinity).

%% Arguments:
%%     Ref = connection_reference()
%%     SQLQuery = string()
%%     Timeout = time_out()
%% Returns:
%%     {selected, ColNames, Rows} | {error, Reason}
%%     Rows = rows()
sql_query(_Ref, _SQLQuery, _Timeout) ->
    ?NOTIMPLEMENTED.
