
E = EllipticCurve("37a")
show(E.plot())

E = E.change_ring(GF(997))
show(E.plot())

