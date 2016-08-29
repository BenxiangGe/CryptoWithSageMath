# Tate Pairing Example
# Example 5.43 in IMC

# E: y^2 = x^3 + 30x + 34 mod 631
p = 631
a = 30
b = 34
E = EllipticCurve(GF(p), [a, b])

print E

P = E((36, 60))
Q = E((121, 387))
n = 5
S = E((0, 36))

print "P =", P.xy()
print "Q =", Q.xy()
print "#P = #Q =", n

var('x y')
def g(P, Q):
	(x_P, y_P) = P.xy()
	(x_Q, y_Q) = Q.xy()
	if x_P == x_Q and y_P + y_Q == 0:
		return x - x_P
	if P == Q:
		slope = (3 * x_P^2 + a)/(2 * y_P)
	else:
		slope = (y_P - y_Q)/(x_P - x_Q)
	return (y - y_P - slope * (x - x_P))/(x + x_P + x_Q - slope^2)

def miller(m, P):
	m = bin(m)[3:]
	n = len(m)
	T = P
	f = 1
	for i in range(n):
		f = f^2 * g(T, T)
		T = T + T
		if int(m[i]) == 1:
			f = f * g(T, P)
			T = T + P
	return f

def eval_miller(P, Q):
	f = miller(n, P)
	(x1, y1) = Q.xy()
	return f(x = x1, y = y1)

def tate_pairing(P, Q, S):
	eta = (p - 1)/n
	num = eval_miller(P, Q+S)/eval_miller(P,  S)
	return (num^eta)

# r is \tau
r = tate_pairing(P, Q, S)
print "r(P, Q) =", r

# r^n = 1
print "r(P, Q)^n =", r^n

P3 = P * 3
Q4 = Q * 4
r12 = tate_pairing(P3, Q4, S)

print "[3]P =", P3.xy()
print "[4]Q =", Q4.xy()
print "r([3]P, [4]Q) =", r12
print "r(P, Q)^12 =", r^12
