import sys

if __name__ == "__main__":
	for line in sys.stdin.readlines():
		parts = line.split()[1:]
		if len(parts) > 10:
			continue
		print " ".join(parts)
