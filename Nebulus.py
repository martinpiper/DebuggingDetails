import binascii


def extractLevel():
    file = open("c:/temp/neb lev1.prg", "rb")
#    file = open("c:/temp/neb default lev1.prg", "rb")
    data = file.read()
    data = data[2:]

    outDataBits = []
    outDataBits.append(0x00)
    outDataBits.append(0x20)
    outDataTiles = []
    outDataTiles.append(0x18)
    outDataTiles.append(0x30)

    # > 300 0 81 85 0   0 0 0 0  0 0 0 0  0 0 0 0  0 0 0 0  0 0 0 0  0 0 0 0  0 0 0 0  0 0 0 0  0 0 0 0  0 0 8 0  0 0 0 0
    towerHeight = 48
    currentRow = 0

    while currentRow < towerHeight:
        compressSingleBitField(currentRow, 0, data, outDataBits, outDataTiles)
        compressSingleBitField(currentRow, 8, data, outDataBits, outDataTiles)

        currentRow = currentRow + 1


    out = open("c:/temp/nebout1bits.prg", "wb")
    out.write(bytearray(outDataBits))
    out.close()

    out = open("c:/temp/nebout1tiles.prg", "wb")
    out.write(bytearray(outDataTiles))
    out.close()

def compressSingleBitField(currentRow, currentSegment, data, outDataBits, outDataTiles):
    currentBitField = 0
    currentBitCount = 8
    while currentBitCount > 0:
        currentBitCount = currentBitCount - 1
        currentBitField = currentBitField >> 1

        currentTile = data[(currentSegment * 256) + currentRow]
        if currentTile != 0:
            currentBitField = currentBitField | 0x80
            outDataTiles.append(currentTile)

        currentSegment = currentSegment + 1

    outDataBits.append(currentBitField)

extractLevel()
