def f(x):
 u,s=[0],{0}
 while u:
	a=u.pop()
	for b in x:
	 c=a^b
	 if c not in s:u+=[c]
	 s.add(c)
 return len(s)