# Pairing


# solinas prime q = 2^a - 2^b - 1, meas s = c = -1
q = 0xfffffffffffffffffffffffffffbffff
a = ceil(log(q, 2))
b = log(2^a - q - 1, 2)
s = -1
c = -1

# prime field and extension field defined by p, p = 11 mod 12
p = 0xbffffffffffffffffffffffffffcffff3

Fp = FiniteField(p)
EFp = EllipticCurve(Fp, [0, 1])

Fp2.<X> = FiniteField(p^2)
EFp2 = EllipticCurve(Fp2, [0, 1])

# zeta used in phi()
zeta = ((p-1)//2) + (Fp(3)^((p + 1)/4)) * X

#A = EFp((0x489a03c58dcf7fcfc97e99ffef0bb4634, 0x510c6972d795ec0c2b081b81de767f808))
#B = EFp((0x40e98b9382e0b1fa6747dcb1655f54f75, 0xb497a6a02e7611511d0db2ff133b32a3f))

# B in E/F_p
(x, y) = A.xy()
x1 = x * zeta
y1 = y + 0 * X
B1 = EFp2(x1, y1)



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
	a = -3 * (x_A)^2
	b = 2 * y_A
	c = -b * y_A - a * x_A
	r = a * x_B + b * y_B + c
	return r

# B in E/F_p^2, A in E/F_p
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

def TateMillerSolinas(A, B, q, a, b, s, c):
	v_num = 1
	v_den = 1
	V = A
	t_num = 1
	t_den = 1

	for n in range(0, b-1):
		t_num = t_num^2
		t_den = t_den^2
		t_num = t_num * EvalTangent1(B, V)
		V = 2*V
		t_den = t_den * EvalVertical1(B, V)

	return 0

