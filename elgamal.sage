# g is the generator of GF(p)

def elgamal_keygen(bits):
	p = random_prime(2^bits)
	Fp = GF(p)
	g = randint(0, p)
	d = randint(0, p)
	g = Fp(g)
	y = g^d
	return ((p, g, y), d)

def elgamal_encrypt(m, pk):
	(p, g, y) = pk
	r = randint(0, p)
	c1 = g^r
	c2 = m * y^r
	return (c1, c2)

def elgamal_decrypt(c, sk):
	(c1, c2) = c
	((p, g, y), d) = sk
	return c1^(-1) * c2

sk = elgamal_keygen(1024)
pk = sk[0]
print "sk:"
print sk
print "pk:"
print pk

m = 123
print "m = %d" %m

c = elgamal_encrypt(m, pk)

print "c:"
print c

m2 = elgamal_decrypt(c, sk)
print "m' = %d" %m2


