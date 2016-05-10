##

bits = 512
p = random_prime(2**bits);
q = random_prime(2**bits);

print "p = %d" %p
print "q = %d" %q

N = p * q;
R = IntegerModRing(N)
print "N = p * q = %d" %N

phi = (p - 1)*(q - 1);
print "phi(N) = (p - 1)*(q - 1) = %d" %phi

e = 2**16 + 1;
d = xgcd(e, phi)[1] % phi;

print "e = %d" %e
print "d = e^-1 mod phi(N) = %d" %d


m = R(123)
c = m^e
m2 = c^d

print "m = %d" %m
print "c = %d" %c
print "m' = %d" %m2

