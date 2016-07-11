#!/usr/bin/env sage -python
# Elliptic Curve Arithmetic
# by GUAN Zhi <guan@pku.edu.cn>

import sys
from sage.all import *

# elliptic curve domain parameters, prime192v1
#
# p = 2**192 - 2**64 - 1
# a = -3
# b = 0x64210519E59C80E70FA7E9AB72243049FEB8DEECC146B9B1
# x = 0x188DA80EB03090F67CBF20EB43A18800F4FF0AFD82FF1012
# y = 0x07192B95FFC8DA78631011ED6B24CDD573F977A11E794811
# n = 0xFFFFFFFFFFFFFFFFFFFFFFFF99DEF836146BC9B1B4D22831
# h = 1


# domain parameters
F = GF(2**192 - 2**64 - 1)
a = F(-3)
b = F(0x64210519E59C80E70FA7E9AB72243049FEB8DEECC146B9B1)
G = [	F(0x188DA80EB03090F67CBF20EB43A18800F4FF0AFD82FF1012),
	F(0x07192B95FFC8DA78631011ED6B24CDD573F977A11E794811)]
n = 0xFFFFFFFFFFFFFFFFFFFFFFFF99DEF836146BC9B1B4D22831
h = 1


# elliptic curve arithmetic
# we use [0, 0] to represent O, the point at infinity
# it should be noted that [0, 0] is not a valid point on curve 'prime192v1'

def point_add(P, Q):

	x1 = P[0]
	y1 = P[1]
	x2 = Q[0]
	y2 = Q[1]

	# check P == O
	if P == [0, 0]:
		return Q

	# check Q == O
	if Q == [0, 0]:
		return P

	# check Q == -P
	if x1 == x2 and y1 + y2 == 0:
		return [0, 0]

	# check P == Q
	if P == Q:
		return point_double(P)

	slope = F((y2 - y1)/(x2 - x1))
	x3 = F(slope**2 - x1 - x2)
	y3 = F(slope * (x1 - x3) - y1)

	return [x3, y3]


def point_double(P):

	if P == [0, 0]:
		return [0, 0]

	x1 = P[0]
	y1 = P[1]

	slope = F((3 * x1**2 + a)/(2 * y1))
	x3 = F(slope**2 - 2 * x1)
	y3 = F(slope * (x1 - x3) - y1)

	return [x3, y3]


def point_mul(k, P):

	if k >= n:
		k = k % n

	if k == 0:
		return [0, 0]

	kbits = []
	while k > 0:
		kbits.append(k % 2)
		k = k // 2
	knbits = len(kbits)

	Q = [0, 0]
	for i in range(knbits):
		Q = point_double(Q)
		if (kbits[knbits - i - 1] == 1):
			Q = point_add(Q, P)

	return Q


# test 2G + G + G == 2(2G)
G2 = point_double(G)
G3 = point_add(G2, G)
G4 = point_add(G3, G)
print "[4]G = %s" %G4

G4 = point_double(G2)
print "[4]G = %s" %G4

# test [n-1]G == -G
n_1G = point_mul(n-1, G)
print "[n-1]G = %s" %n_1G

n_1G = [G[0], -G[1]]
print "[n-1]G = %s" %n_1G

# test [n]G == O
R = point_add(G, n_1G)
print "[n]G = %s" %R


# random key pair
sk = randint(1, n-1)
pk = point_mul(sk, G)
print "private key = %d" %sk
print "public key  = %s" %pk

