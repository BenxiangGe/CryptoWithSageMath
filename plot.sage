
# E: Y^2 = X^3 + AX + B

# Example from Book
# Y^2 = x^3 + 3X + 8 over GF(13)

E = EllipticCurve(GF(13), [3,8])


# E1: Y^2 = X^3 - 3*X + 3
E1 = EllipticCurve([2, 3])
show(E1.plot())

#E = EllipticCurve("37a")
#show(E.plot())

#E = E.change_ring(GF(997))
#show(E.plot())

