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
