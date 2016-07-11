# Lamport's One-Time Signature Scheme

import os
import hashlib
import binascii

# k is the bit length security, used to choose hash function
# n is the message bit length
def lamport_keygen(k, n):
	sk = []
	pk = []
	for i in range(n):
		x0 = binascii.hexlify(os.urandom(k/8))
		x1 = binascii.hexlify(os.urandom(k/8))
		y0 = hashlib.sha1(x0).hexdigest()
		y1 = hashlib.sha1(x1).hexdigest()
		sk.append((x0, x1))
		pk.append((y0, y1))
	return (sk, pk)

# message m should be bit string
def lamport_sign(m, sk):
	sig = []
	for i in range(len(m)):
		sig.append(sk[i][int(m[i])])
	return sig

(sk,pk) = lamport_keygen(160, 6)
print (sk, pk)

m = '100101'
print lamport_sign(m, sk)
