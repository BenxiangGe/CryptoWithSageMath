
F1 = GF(37)
print F1

F2 = GF(95131)
print F2

#F3 = GF(256)
#print F3

F4.<a> = GF(256)
print F4

print ""

F.<x> = GF(128)
a = x^2 + 1
b = x^5 + x^3 + 1

print "a = ", a
print "b = ", b
print "a - b = ", a - b
print "a + b = ", a + b
print "a * b = ", a * b
print "a / b = ", a / b
print "a^-1 = ", a^-1
print "1/b = ", 1/b
print ""


