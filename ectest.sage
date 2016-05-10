# test ec_keygen and ecdsa

load("prime192v1.sage")
load("digest.sage")
load("eckeygen.sage")
load("ecdsa.sage")

(Q, d) = ec_keygen()
m = 'signed message'

[r, s] = ecdsa_sign(d, m)
result = ecdsa_verify(Q, m, r, s)

print "EC Public Key       : ", Q.xy()
print "EC Private Key      : ", d
print "Signed Message      : ", m
print "ECDSA Signature     : "
print " r = ", r
print " s = ", s
print "Verification Result : ", result
