# Bilinear Pairing

# supersingular curve
# E: y^2 = x^3 + 1 (mod p)
# p = 11 (mod 12)
# normally choose p as a solinas prime
p = 2**192 - 2**64 - 1
print "p = 2^192 - 2^64 - 1 = ", p
print "p mod 12 = ", p % 12

Fp = FiniteField(p)
a = 0
b = 1

EFp = EllipticCurve(Fp, [a, b])
print "E", EFp
print "#E", EFp.order()
print "p + 1 = ", p+1

# generate random point A on E(Fp)
k = -(p-2)/3
yA = Fp(randint(0, p-1))
xA = (yA^2 - 1)^k
A = EFp((3490623488107933015424560092111020851745800620910508679457, 3152942073915555186624051209510405406193824922764565481462))
#print A


Fp2.<x> = FiniteField(p^2)



EFp2 = EllipticCurve(Fp2, [a, b])
#print EFp2.order()
#print (p+1)^2

B = EFp2((3490623488107933015424560092111020851745800620910508679457, 3152942073915555186624051209510405406193824922764565481462))
#print B


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
	return (y - yP - slope * (x - xP))/(x + xP + xQ - slope^2)

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

print g(A, A)

