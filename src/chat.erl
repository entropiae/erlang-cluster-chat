-module(chat).

-behaviour(gen_server).

-export([start_link/0, send_message/1]).

-export([init/1,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    terminate/2,
    code_change/3]).

-define(SERVER, ?MODULE).

-spec(start_link() ->
    {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
    io:format("Starting chat node ~n"),
    _ = net_kernel:monitor_nodes(true, []),
    {ok, state}.

send_message(Message) ->
    {Replies, BadNodes} = gen_server:multi_call([node() | nodes()], ?SERVER, {node(), Message}, 10000),
    io:format("Node Replies ~p - Bad Nodes ~p ~n", [Replies, BadNodes]),
    ok.

handle_call({Node, Message}, _, state) ->
    io:format("[message from ~p] ~s ~n", [Node, Message]),
    {reply, Message, state}.


handle_info({nodeup, Node}, State) ->
    io:format("Node ~p is up ~n", [Node]),
    print_nodes(),
    {noreply, State};

handle_info({nodedown, Node}, State) ->
    io:format("Node ~p  is down ~n", [Node]),
    print_nodes(),
    {noreply, State}.

print_nodes() ->
    io:format("Cluster status:~p ~p ~n", [node(), nodes()]),
    ok.

handle_cast({command, Status, Task_Node, H}, State) ->
    io:format("Received status: ~p from node: ~p  value: ~p ~n", [Status, Task_Node, H]),
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
