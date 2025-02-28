# m4-lists
m4 macros for lists

## Summary

These m4 macros allow to create and to expand lists in m4.
They are useful whenever a Cartesian product of configuration lines
is required. This is particularly helpful in the context of firewall
configurations.

Suggest you have a list of local IP addresses and a list of TCP
ports that are to be accessible for each of the local IP addresses.
Then you start by defining the two lists:

```m4
def_list(LOCAL)
def_list(TCP)
```

`def_list(LOCAL)` creates now multiple macros named `LOCAL_add`,
`LOCAL_len`, and `LOCAL_expand`. `LOCAL_add` can now be used
to add IP addresses:

```m4
LOCAL_add(10.42.0.0/16)
LOCAL_add(10.200.0.42)
```

The individual members are accessible through `LOCAL_val_0` and
`LOCAL_val_1`. And `LOCAL_len` delivers the number of members.

Likewise we have `TCP_add`, `TCP_len`, and `TCP_expand`.
Using `TCP_add` we can add TCP ports:

```m4
TCP_add(22)
TCP_add(143)
```

Both lists can now be combined to create a Cartesian product of
firewall rules:

```m4
LOCAL_expand(`NET', `TCP_expand(`PORT', `pass in quick proto tcp from NET to any to port = PORT')')
```

`LOCAL_expand` expands its second parameter for each of the list
members of `LOCAL` and uses its first parameter, i. e. `NET', as
loop variable that is defined to the corresponding member of the
`LOCAL` list. List expansions can be nested such that we get
the Cartesian product of both lists:

```
$ cat example.m4 
include(lists.m4)dnl
divert(-1)dnl
def_list(LOCAL)
LOCAL_add(10.42.0.0/16)
LOCAL_add(10.200.0.42)

def_list(TCP)
TCP_add(22)
TCP_add(143)
divert(0)dnl
LOCAL_expand(`NET', `TCP_expand(`PORT', `pass in quick proto tcp from NET to any to port = PORT')')
$ m4 example.m4
pass in quick proto tcp from 10.42.0.0/16 to any to port = 22
pass in quick proto tcp from 10.42.0.0/16 to any to port = 143
pass in quick proto tcp from 10.200.0.42 to any to port = 22
pass in quick proto tcp from 10.200.0.42 to any to port = 143
$ 
```

## License

This package is available under the terms of
the [MIT License](https://opensource.org/licenses/MIT).
