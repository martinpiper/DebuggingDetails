import sys

with open(sys.argv[1]) as file:
    lines = [line.rstrip() for line in file]

changedLines = 0
# One pass to fix superfluous '+' in the source file
for index, line in enumerate(lines):
    comment = ""
    pos = line.find(';')
    if pos != -1:
        comment = line[pos:]
        line = line[0:pos]

    if line.find(" +") != -1:
        line = line.replace("+", "") + comment
        lines[index] = line
        changedLines += 1

    if line.find(",+") != -1:
        line = line.replace("+", "") + comment
        lines[index] = line
        changedLines += 1

while True:
    changedLines = 0

    for index, line in enumerate(lines):

        if line.find("EQU") != -1:
            lines[index] = line.replace("EQU", "=")
            changedLines += 1
            continue

        if line.find("ORG") != -1:
            lines[index] = line.replace("ORG", "* =").strip()
            changedLines += 1
            continue

        if line.find(".-") != -1:
            lines[index] = line.replace(".-", "*-")
            changedLines += 1
            continue

        pos = line.find("#&")
        if pos != -1:
            lines[index] = line[0:pos] + "#'" + line[pos + 2] + "'" + line[pos + 3:]
            changedLines += 1
            continue

        if line.find("Jmp") != -1 and line.find("JmpLabel") == -1:
            lines[index] = line.replace("Jmp", "JmpLabel")
            changedLines += 1
            continue

        if line.find("DFS") != -1:
            if line.find(",") != -1:
                lines[index] = line.replace("DFS", "!fill")
            else:
                lines[index] = line.replace("DFS", "* = * + ")
            changedLines += 1
            continue

        # Now work on any lines with code and comments, separately
        comment = ""
        pos = line.find(';')
        if pos != -1:
            comment = line[pos:]
            line = line[0:pos]

        pos = line.find("#<+")
        if pos != -1:
            lines[index] = line[0:pos+2] + line[pos + 3:] + comment
            changedLines += 1
            continue

        pos = line.find("ENT")
        if pos != -1:
            lines[index] = line[0:pos] + "; Entry " + line[pos:] + comment
            changedLines += 1
            continue

        pos = line.find("&")
        if (pos != -1) and (line.find("'") == -1):
            line = line[0:pos] + "'" + line[pos + 1] + "'" + line[pos + 2:]
            lines[index] = line + comment
            changedLines += 1
            continue

        if line.find("LSR A") != -1:
            lines[index] = line.replace("LSR A", "lsr") + comment
            changedLines += 1
            continue

        if line.find("LSRA") != -1:
            lines[index] = line.replace("LSRA", "lsr") + comment
            changedLines += 1
            continue

        if line.find("DFW") != -1 and line.find("-") != -1:
            lines[index] = line.replace("DFW", "+SafeWord") + comment
            changedLines += 1
            continue

        if line.find("DFW") != -1:
            lines[index] = line.replace("DFW", "!word") + comment
            changedLines += 1
            continue

        if line.find("DFB") != -1:
            lines[index] = line.replace("DFB", "!by <") + comment
            changedLines += 1
            continue

        if line.find("DFM") != -1:
            lines[index] = line.replace("DFM", "!tx") + comment
            changedLines += 1
            continue

        if (line.find("DFL") != -1) and (line.find("+DFL") == -1):
            lines[index] = line.replace("DFL", "+DFL") + comment
            changedLines += 1
            continue

        if (line.find("DFH") != -1) and (line.find("+DFH") == -1):
            lines[index] = line.replace("DFH", "+DFH") + comment
            changedLines += 1
            continue

        # Some LDX # values are out of range (256, $0002) so prefix them all with <
        if (line.find(" #") != -1) and (line.find("<") == -1) and (line.find(">") == -1):
            lines[index] = line.replace(" #", " #<") + comment
            changedLines += 1
            continue

        pos = line.find(" ^")
        if (pos != -1) and (line.find(">") == -1):
            line = line[0:pos] + " #>" + line[pos + 2:]
            lines[index] = line + comment
            changedLines += 1
            continue

        pos = line.find("ADD")
        if pos != -1:
            line = line[0:pos] + "clc : adc" + line[pos+3:]
            lines[index] = line + comment
            changedLines += 1
            continue

        pos = line.find("SUB")
        if pos != -1:
            line = line[0:pos] + "sec : sbc" + line[pos+3:]
            lines[index] = line + comment
            changedLines += 1
            continue

        # Converts labels with '.' to be labels with '_'
        findLabel = line.split()
        if len(findLabel) > 0 and line.startswith(findLabel[0]):
            if findLabel[0].find('.') != -1 and findLabel[0].find('_') == -1:
                label = findLabel[0].replace(".", "_")
                # Now update all labels to match
                for index2, line2 in enumerate(lines):
                    if line2.find(findLabel[0]) != -1:
                        lines[index2] = line2.replace(findLabel[0], label)
                        changedLines += 1
                continue

    print("Lines changed", changedLines)
    if changedLines == 0:
        break

with open(sys.argv[2], 'w') as f:
    for line in lines:
        f.write(f"{line}\n")
