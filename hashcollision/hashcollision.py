def hsh(txt):
    # txt = input("Enter a string: ")
    if len(txt) < 1:
        pass

    hv = 0
    pos = 0
    for let in txt:
        pos = ( pos + 1 ) % 4
        hv = (hv + (pos * ord(let))) % 1000000
        print(let, pos, ord(let), hv)

    print(hv, txt)



if __name__ == '__main__':
    for let in range(ord('A'), ord('Z')):
        print(hsh(chr(let)))


# Actually, let me use the fact that position multiplier can be 0:
# "AAAA" → 1*65 + 2*65 + 3*65 + 0*65 = 65 + 130 + 195 + 0 = 390
# "AAAD" → 1*65 + 2*65 + 3*65 + 0*68 = 65 + 130 + 195 + 0 = 390 ✓
#
# Found a collision!
# String 1: "AAAA" → hash = 390
# String 2: "AAAD" → hash = 390

# To find collisions, we need:
#
# text
# (1*a1 + 2*a2 + 3*a3 + 0*a4 + 1*a5 + ...) ≡
# (1*b1 + 2*b2 + 3*b3 + 0*b4 + 1*b5 + ...) mod 1000000