import sys,re

if __name__ == "__main__":
	for line in sys.stdin.readlines():
		parts = unicode(line,"utf-8").split()
		if len(parts) < 6: continue
		print u"".join(a[0] for a in parts).encode("latin-1","replace")

