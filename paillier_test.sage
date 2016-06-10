# test paillier
load("paillier.sage")

sk = paillier_keygen_simple(512)
pk = sk[0]
print "sk = ", sk

m1 = randint(0, 1000)
c1 = paillier_encrypt(m1, pk)

print "m1 = %d" %m1
print "c1 = %d" %c1

m2 = randint(0, 1000)
c2 = paillier_encrypt(m2, pk)

print "m1 = ", m2
print "m2 = ", c2

sum = paillier_ciphertext_add(c1, c2, pk)
print "m1 + m2 = ", m1 + m2
print "m1 + m2 = ", paillier_decrypt(sum, sk)

ret = paillier_ciphertext_linear(2, c1, 3, c2, pk)
print "2 * m1 + 3 * m2 = ", 2*m1 + 3*m2
print "2 * m1 + 3 * m2 = ", paillier_decrypt(ret, sk)


