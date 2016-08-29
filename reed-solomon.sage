# Reed-Solomon Coding
# (255, 233)

# parameters of reed-solomon (255, 233)
F.<x> = GF(2^8)
n = 255
k = 233

# generate random message m, m[i] in [0, n]
m = []
for i in range(k):
	m.append(F.random_element())
print m

# the polynomial is f(x) = m[0] + m[1]*X + ... + m[k-1]*X^(k-1)
var ('X')
f = 0
for i in range(k):
	f = f + m[i] * X^i
#print f

c = []
for i in range(1, n+1):
	c.append(f(X=F(i)))
print c
