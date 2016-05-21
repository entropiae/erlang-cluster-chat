# Erlang Cluster Chat

Inspired by [hokuto](https://github.com/Gsantomaggio/hokuto), developed during Elixir Italia Meetup - 21/05/2016

## HowTo:
```shell
git clone https://github.com/entropiae/erlang-cluster-chat.git
cd erlang-cluster-chat
./build.sh
./run_chat.sh 1

# Now, in another shell..
./run_chat.sh 2
```

```erlang
%% Go back in the first shell and write..
1> net_kernel:connect(node2@hostname).
2> chat:send_message("Hello Cthulhu").
%% Go check the second shell
```

Note: BEAM should be able to resolve *hostname* to your current ip; ie through a "127.0.0.1 hostname" entry in /etc/hosts.