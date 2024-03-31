import binascii


def extractLevel(levelNum):
    file = open("c:/temp/pd.prg", "rb")
    data = file.read()
    levelOffset = data[0xf100 + levelNum] | (data[0xf110 + levelNum] << 8)

    print(levelNum, "offset", hex(levelOffset))

    outData = []

    while (len(outData) < 64 * 16):
        currentByte = data[levelOffset]
        levelOffset = levelOffset + 1

        repeatBytes = 1
        if (currentByte & 0x80) != 0:
            repeatBytes = data[levelOffset]
            levelOffset = levelOffset + 1

        currentByte = currentByte & 0x1f

        while repeatBytes > 0:
            outData.append(currentByte)
            repeatBytes = repeatBytes - 1

    out = open("c:/temp/out" + str(levelNum) + ".bin", "wb")

    out.write(bytearray(outData))

    out.close()


for x in range(16):
    extractLevel(x)
