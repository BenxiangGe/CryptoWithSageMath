
var('x y')
f = 1 + 2*x + y^2
print f(x=2, y=3)
print f
print f^2 + 2*f + 1

g = f / (x + y)

print g

