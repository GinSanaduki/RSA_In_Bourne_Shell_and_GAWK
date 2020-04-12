#!/usr/bin/python
# testoo.py
# python testoo.py > SampleResult_Python.txt
# python -m pdb testoo.py

import random

def modular_exp(a, b, n):
	res = 1
	while b != 0:
		if b & 1 != 0:
			res = (res * a) % n
		a = (a * a) % n
		b = b >> 1
	return res

def gen_rand(bit_length):
	bits = [random.randint(0,1) for _ in range(bit_length - 2)]
	ret = 1
	for b in bits:
		ret = ret * 2 + int(b)
	return ret * 2 + 1

def mr_primary_test(n, k=100):
	if n == 1:
		return False
	if n == 2:
		return True
	if n % 2 == 0:
		return False
	d = n - 1
	s = 0
	while d % 2 != 0:
		d /= 2
		s += 1
	
	r = [random.randint(1, n - 1) for _ in range(k)]
	for a in r:
		if modular_exp(a, d, n) != 1:
			pl = [(2 ** rr) * d for rr in range(s)]
			flg = True
			for p in pl:
				if modular_exp(a, p, n) == 1:
					flg = False
					break
			if flg:
				return False
	print(r);
	return True

def gen_prime(bit):
	while True:
		ret = gen_rand(bit)
		if mr_primary_test(ret):
			break
	return ret

def xgcd(b, n):
	x0, x1, y0, y1 = 1, 0, 0, 1
	while n != 0:
		q, b, n = b // n, n, b % n
		x0, x1 = x1, x0 - q * x1
		y0, y1 = y1, y0 - q * y1
	return b, x0, y0

def gen_d(e, l):
	_, x, _ = xgcd(e, l)
	return x % l

hog = 250382861499762566692523265395270151499
print('hog : ' + str(hog))
mr_primary_test(hog, k=100)

bit_length = 128

p = gen_prime(bit_length)
q = gen_prime(bit_length)
e = 65537

print('p : ' + str(p))
print('q : ' + str(q))
print('e : ' + str(e))

d = gen_d(e, (p - 1) * (q - 1))
n = p * q

print('d : ' + str(d))
print('n : ' + str(n))

m = 123456789
c = modular_exp(m, e, n)  # 暗号文
m_ = modular_exp(c, d, n)  # 123456789

print('m : ' + str(m))
print('c : ' + str(c))
print('m_ : ' + str(m_))

