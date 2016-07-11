# Algorithm 4.1.1 HashToRange

import hashlib

hashfcn = hashlib.sha1()
hashlen = 20

s = "This ASCII string without null-terminator"
n = 0xffffffffffffffffffffefffffffffffffffffff
v = 0x79317c1610c1fc018e9c53d89d59c108cd518608

#    1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0
h0 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

hashfcn.update(h0)
hashfcn.update(s)
h1 = hashfcn.digest()


a = Integer('0x' + hashfcn.hexdigest())


h_1 = digest(t_1)
a_1 = Integer(h_1)
v_1 = a_1

h_2 = digest(t_2)
a_2 = Integer(h_2)
v_2 = v_1 * 256^20 + a_2

v = v_2 % n

