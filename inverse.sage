
print "gcd(15, 100) = ", gcd(15, 100)

# extended euclidean algorithm
# help(xgcd)
print "xgcd(17, 31) = ", xgcd(17, 31)

R = IntegerModRing(31)
a = R(17)
print "17^-1 mod 31 = ", a^-1
 
