-record(sql_connect, {host, port, database, user, password, options}).
-record(sql_query, {q}).
-record(sql_param_query, {q, params}).
-record(sql_select_count, {q}).
-record(sql_select, {pos, n}).
-record(sql_first, {}).
-record(sql_last, {}).
-record(sql_next, {}).
-record(sql_prev, {}).
