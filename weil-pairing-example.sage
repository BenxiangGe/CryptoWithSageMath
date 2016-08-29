# Weil Pairing Example
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


f_P = miller(n, P)
(x1, y1) = (Q + S).xy()
(x2, y2) = S.xy()
num = f_P(x = x1, y = y1)
den = f_P(x = x2, y = y2)
u = num/den

f_Q = miller(n, Q)
(x3, y3) = (P - S).xy()
(x4, y4) = (-S).xy()
num = f_Q(x = x3, y = y3)
den = f_Q(x = x4, y = y4)
v = num/den

e = u/v

print "e(P, Q) =", e

# e^n = 1
print "e(P, Q)^n =", e^n

