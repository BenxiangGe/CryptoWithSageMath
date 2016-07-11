# type-1 supersingular curve
# E/F_p : y^2 = x^3 + 1 mod p, p = 11 mod 12
#
# p = 2**192 - 2**64 - 1
# a = 0
# b = 1

p = 0xbffffffffffffffffffffffffffcffff3
Fp = FiniteField(p)
a = 0
b = 1
E = EllipticCurve(Fp, [a, b])

#print "p = ", p
#print "p mod 12 = ", p % 12

A = E((0x489a03c58dcf7fcfc97e99ffef0bb4634, 0x510c6972d795ec0c2b081b81de767f808))
l = 0xb8bbbc0089098f2769b32373ade8f0daf
lA = l * A
#print lA

Fp2.<x> = FiniteField(p^2)
EFp2 = EllipticCurve(Fp2, [a, b])
print EFp2

#xlA = 0x073734b32a882cc97956b9f7e54a2d326
#ylA = 0x9c4b891aab199741a44a5b6b632b949f7



