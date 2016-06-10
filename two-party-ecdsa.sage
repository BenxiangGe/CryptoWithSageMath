# two party generation of ecdsa signature
# based on paillier encryption
# use `sage <filename.sage>` to execute the sage script

load("prime192v1.sage")
load("digest.sage")
load("eckeygen.sage")
load("ecdsa.sage")
load("paillier.sage")

# Alice keygen
(QA, dA) = ec_keygen()
print "    Alice's ECDSA keypair : ", (QA, dA)

# Bob keygen
(QB, dB) = ec_keygen()
print "    Bob's ECDSA keypair : ", (QB, dB)

# Joint public key can be generate with ECDH
# but neither Alice nor Bob has the joint private key `d`
d = (dA * dB) % n
Q = dA * QB
print "    Joint ECDSA keypair : ", (Q, d)
#print "    Joint ECDSA keypair :", (d*P, d)

# start of the two-party siganture generation
# Alice receives the message to be signed and will
# return the final signature

m = "message to be signed"
e = digest(m)


# Alice generate temp keypair (TA, kA)
(TA, kA) = ec_keygen()

# Bob generate temp keypair (TB, kB)
(TB, kB) = ec_keygen()

# Alice and Bob exchange temp public key and use ECDH to
# generate `r`
k = (kA * kB) % n
T = kA * TB
(x, y) = T.xy()
r = Fn(x)
s = (Fn(k)^-1) * (e + d * r)
#print "    Joint ECDSA Signature : ", (r, s)

# Alice generate her Paillier keypair
# it will be very slow, you can change bits to 512 to make it faster
bits = 512
sk = paillier_keygen_simple(bits)
pk = sk[0]
print "    Alice's Paillier keypair : ", sk


# Alice's secets are kA and dA
# Alice convert secret to kA^-1, kA^-1 * dA

uA = Fn(kA)^(-1)
vA = uA * dA

euA = paillier_encrypt(uA, pk)
evA = paillier_encrypt(vA, pk)

# Alice send euA, evA to Bob

# Bob generate the signature ciphertext
a1 = Fn(kB)^(-1) * e
a2 = Fn(kB)^(-1) * dB * r

es = paillier_ciphertext_linear(a1, euA, a2, evA, pk)

# Bob send encrypted sigature esig to Alice
# Alice decrytp it with her paillier private key `sk`

s = paillier_decrypt(es, sk)
s = Fn(s)
print "    Joint ECDSA Signature : ", (r, s)

ret = ecdsa_verify(Q, m, r, s)

print "    Verification Result : ", ret

