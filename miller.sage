# Pairing


# solinas prime q = 2^a + s * 2^b + c
q = 0xfffffffffffffffffffffffffffbffff
a = ceil(log(q, 2))
b = log(2^a - q - 1, 2)
s = -1
c = -1

# prime field defined by p, p = 11 mod 12, q|p
p = 0xbffffffffffffffffffffffffffcffff3

Fp = FiniteField(p)
EFp = EllipticCurve(Fp, [0, 1])

Fp2.<A> = FiniteField(p)[]
Fp2.<X> = FiniteField(p^2, name='X', modulus=A^2+1)
EFp2 = EllipticCurve(Fp2, [0, 1])

# B in E/F_p^2, A in E/F_p
def EvalVertical1(B, A):
	(x_A, y_A) = A.xy()
	(x_B, y_B) = B.xy()
	r = x_B - x_A
	return r

# B in E/F_p^2, A in E/F_p
def EvalTangent1(B, A):
	(x_A, y_A) = A.xy()
	(x_B, y_B) = B.xy()
	if A == EFp(0):
		return 1
	if y_A == 0:
		return EvalVertical1(B, A)
	a = -3 * x_A^2
	b = 2 * y_A
	c = -b * y_A - a * x_A
	r = a * x_B + b * y_B + c
	return r

# B in E/F_p^2, A1, A2 in E/F_p
def EvalLine1(B, A1, A2):
	(x_A1, y_A1) = A1.xy()
	(x_A2, y_A2) = A2.xy()
	(x_B, y_B) = B.xy()
	if A1 == EFp(0):
		return EvalVertical1(B, A2)
	if A2 == EFp(0):
		return EvalVertical1(B, A1)
	if A1 == -A2:
		return EvalVertical1(B, A1)
	if A1 == A2:
		return EvalTangent1(B, A1)
	a = y_A1 - y_A2
	b = x_A2 - x_A1
	c = -b * y_A1 - a * x_A1
	r = a * x_B + b * y_B + c
	return r

# B in E/F_p^2, A in E/F_p
def TateMillerSolinas(A, B):
	v_num = Fp2(1)
	v_den = Fp2(1)
	t_num = Fp2(1)
	t_den = Fp2(1)
	V = A

	# Calculation of the (s * 2^b) contribution
	for i in range(b):
		t_num = t_num^2
		t_den = t_den^2
		t_num = t_num * EvalTangent1(B, V)
		V = 2*V
		t_den = t_den * EvalVertical1(B, V)

	# Normalization
	(x,y) = V.xy()
	V_b = EFp(x, s*y)

	# Accumulation
	if s == -1:
		v_num = v_num * t_den
		v_den = v_den * t_num * EvalVertical1(B, V)
	if s == 1:
		v_num = v_num * t_num
		v_den = v_den * t_den

	# Calculation of the 2^a contribution
	for i in range(b, a):
		t_num = t_num^2
		t_den = t_den^2
		t_num = t_num * EvalTangent1(B, V)
		V = 2*V
		t_den = t_den * EvalVertical1(B, V)

	# Normalization
	(x, y) = V.xy()
	V_a = EFp(x, s*y)

	# Accumulation
	v_num = v_num * t_num
	v_den = v_den * t_den

	# Correction for the (s * 2^b) and (c) contributions
	v_num = v_num * EvalLine1(B, V_a, V_b)
	v_den = v_den * EvalVertical1(B, V_a + V_b)

	if c == -1:
		v_den = v_den * EvalVertical1(B, A)

	# Correcting exponent
	eta = (p^2 - 1) / q

	r = (v_num / v_den)^eta
	return r

# map from E(F_p) to E(F_p^2)
zeta = Fp((p-1)/2) + ((Fp(3)^((p + 1)/4))/2)*X

def phi(B):
	(x, y) = B.xy()
	return EFp2((x * zeta, y))

# A, B in E(F_p)
def Pairing1(A, B):
	return TateMillerSolinas(A, phi(B))

A = EFp((0x489a03c58dcf7fcfc97e99ffef0bb4634, 0x510c6972d795ec0c2b081b81de767f808))
B = EFp((0x40e98b9382e0b1fa6747dcb1655f54f75, 0xb497a6a02e7611511d0db2ff133b32a3f))
eAB = (0x8b2cac13cbd422658f9e5757b85493818, 0xbc6af59f54d0a5d83c8efd8f5214fad3c)

print phi(B)
#print TateMillerSolinas(A, B)
print Pairing1(2*A, B)
print (Pairing1(A, B))^2

#print eAB
