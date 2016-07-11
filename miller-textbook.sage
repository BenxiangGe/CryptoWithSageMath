

p = 2**192 - 2**64 - 1
Fp = FiniteField(p)
a = 0
b = 1
Fp2.<x> = FiniteField(p^2)
EFp2 = EllipticCurve(Fp2, [a, b])

# we need to random a point on E(F_p^2)
def random_point():
	yP = os.random()

var('X Y')

def g(P, Q):
	(xP, yP) = P.xy()
	(xQ, yQ) = Q.xy()
	if xP == xQ and yQ != yQ:
		return X - xP
	if P == Q:
		slope = (3 * xP^2 + a)/(2 * yP)
	else:
		slope = (yP - yQ)/(xP - xQ)
	return (Y - yP - slope * (X - xP))/(X + xP + xQ - slope^2)

def miller(m, P):
	m = bin(m)[2:]
	n = len(m)
	T = P
	f = 1
	for i in range(n - 1):
		f = f^2 * g(T, T)
		T = T + T
		if int(m[i]) == 1:
			f = f * g(T, P)
			T = T + P
	return f

def 
