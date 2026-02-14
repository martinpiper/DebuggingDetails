# References:
# http://amiga-dev.wikidot.com/hardware:copins
# https://www.amigarealm.com/computing/knowledge/hardref/ch2.htm

regToText = {
    0x000: "BLTDDAT",
    0x002: "DMACONR",
    0x004: "VPOSR",
    0x006: "VHPOSR",
    0x008: "DSKDATR",
    0x00A: "JOY0DAT",
    0x00C: "JOY1DAT",
    0x00E: "CLXDAT",
    0x010: "ADKCONR",
    0x012: "POT0DAT",
    0x014: "POT1DAT",
    0x016: "POTINP",
    0x018: "SERDATR",
    0x01A: "DSKBYTR",
    0x01C: "INTENAR",
    0x01E: "INTREQR",
    0x020: "DSKPTH",
    0x022: "DSKPTL",
    0x024: "DSKLEN",
    0x026: "DSKDAT",
    0x028: "REFPTR",
    0x02A: "VPOSW",
    0x02C: "VHPOSW",
    0x02E: "COPCON",
    0x030: "SERDAT",
    0x032: "SERPER",
    0x034: "POTGO",
    0x036: "JOYTEST",
    0x038: "STREQU",
    0x03A: "STRVBL",
    0x03C: "STRHOR",
    0x03E: "STRLONG",
    0x040: "BLTCON0",
    0x042: "BLTCON1",
    0x044: "BLTAFWM",
    0x046: "BLTALWM",
    0x048: "BLTCPTH",
    0x04A: "BLTCPTL",
    0x04C: "BLTBPTH",
    0x04E: "BLTBPTL",
    0x050: "BLTAPTH",
    0x052: "BLTAPTL",
    0x054: "BLTDPTH",
    0x056: "BLTDPTL",
    0x058: "BLTSIZE",
    0x05A: "BLTCON0L",
    0x05C: "BLTSIZV",
    0x05E: "BLTSIZH",
    0x060: "BLTCMOD",
    0x062: "BLTBMOD",
    0x064: "BLTAMOD",
    0x066: "BLTDMOD",
    0x070: "BLTCDAT",
    0x072: "BLTBDAT",
    0x074: "BLTADAT",
    0x078: "SPRHDAT",
    0x07A: "BPLHDAT",
    0x07C: "DENISEID",
    0x07E: "DSKSYNC",
    0x080: "COP1LCH",
    0x082: "COP1LCL",
    0x084: "COP2LCH",
    0x086: "COP2LCL",
    0x088: "COPJMP1",
    0x08A: "COPJMP2",
    0x08C: "COPINS",
    0x08E: "DIWSTRT",
    0x090: "DIWSTOP",
    0x092: "DDFSTRT",
    0x094: "DDFSTOP",
    0x096: "DMACON",
    0x098: "CLXCON",
    0x09A: "INTENA",
    0x09C: "INTREQ",
    0x09E: "ADKCON",
    0x0A0: "AUD0LCH",
    0x0A2: "AUD0LCL",
    0x0A4: "AUD0LEN",
    0x0A6: "AUD0PER",
    0x0A8: "AUD0VOL",
    0x0AA: "AUD0DAT",
    0x0B0: "AUD1LCH",
    0x0B2: "AUD1LCL",
    0x0B4: "AUD1LEN",
    0x0B6: "AUD1PER",
    0x0B8: "AUD1VOL",
    0x0BA: "AUD1DAT",
    0x0C0: "AUD2LCH",
    0x0C2: "AUD2LCL",
    0x0C4: "AUD2LEN",
    0x0C6: "AUD2PER",
    0x0C8: "AUD2VOL",
    0x0CA: "AUD2DAT",
    0x0D0: "AUD3LCH",
    0x0D2: "AUD3LCL",
    0x0D4: "AUD3LEN",
    0x0D6: "AUD3PER",
    0x0D8: "AUD3VOL",
    0x0DA: "AUD3DAT",
    0x0E0: "BPL1PTH",
    0x0E2: "BPL1PTL",
    0x0E4: "BPL2PTH",
    0x0E6: "BPL2PTL",
    0x0E8: "BPL3PTH",
    0x0EA: "BPL3PTL",
    0x0EC: "BPL4PTH",
    0x0EE: "BPL4PTL",
    0x0F0: "BPL5PTH",
    0x0F2: "BPL5PTL",
    0x0F4: "BPL6PTH",
    0x0F6: "BPL6PTL",
    0x0F8: "BPL7PTH",
    0x0FA: "BPL7PTL",
    0x0FC: "BPL8PTH",
    0x0FE: "BPL8PTL",
    0x100: "BPLCON0",
    0x102: "BPLCON1",
    0x104: "BPLCON2",
    0x106: "BPLCON3",
    0x108: "BPL1MOD",
    0x10A: "BPL2MOD",
    0x10C: "BPLCON4",
    0x10E: "CLXCON2",
    0x110: "BPL1DAT",
    0x112: "BPL2DAT",
    0x114: "BPL3DAT",
    0x116: "BPL4DAT",
    0x118: "BPL5DAT",
    0x11A: "BPL6DAT",
    0x11C: "BPL7DAT",
    0x11E: "BPL8DAT",
    0x120: "SPR0PTH",
    0x122: "SPR0PTL",
    0x124: "SPR1PTH",
    0x126: "SPR1PTL",
    0x128: "SPR2PTH",
    0x12A: "SPR2PTL",
    0x12C: "SPR3PTH",
    0x12E: "SPR3PTL",
    0x130: "SPR4PTH",
    0x132: "SPR4PTL",
    0x134: "SPR5PTH",
    0x136: "SPR5PTL",
    0x138: "SPR6PTH",
    0x13A: "SPR6PTL",
    0x13C: "SPR7PTH",
    0x13E: "SPR7PTL",
    0x140: "SPR0POS",
    0x142: "SPR0CTL",
    0x144: "SPR0DATA",
    0x146: "SPR0DATB",
    0x148: "SPR1POS",
    0x14A: "SPR1CTL",
    0x14C: "SPR1DATA",
    0x14E: "SPR1DATB",
    0x150: "SPR2POS",
    0x152: "SPR2CTL",
    0x154: "SPR2DATA",
    0x156: "SPR2DATB",
    0x158: "SPR3POS",
    0x15A: "SPR3CTL",
    0x15C: "SPR3DATA",
    0x15E: "SPR3DATB",
    0x160: "SPR4POS",
    0x162: "SPR4CTL",
    0x164: "SPR4DATA",
    0x166: "SPR4DATB",
    0x168: "SPR5POS",
    0x16A: "SPR5CTL",
    0x16C: "SPR5DATA",
    0x16E: "SPR5DATB",
    0x170: "SPR6POS",
    0x172: "SPR6CTL",
    0x174: "SPR6DATA",
    0x176: "SPR6DATB",
    0x178: "SPR7POS",
    0x17A: "SPR7CTL",
    0x17C: "SPR7DATA",
    0x17E: "SPR7DATB",
    0x180: "COLOR00",
    0x182: "COLOR01",
    0x184: "COLOR02",
    0x186: "COLOR03",
    0x188: "COLOR04",
    0x18A: "COLOR05",
    0x18C: "COLOR06",
    0x18E: "COLOR07",
    0x190: "COLOR08",
    0x192: "COLOR09",
    0x194: "COLOR10",
    0x196: "COLOR11",
    0x198: "COLOR12",
    0x19A: "COLOR13",
    0x19C: "COLOR14",
    0x19E: "COLOR15",
    0x1A0: "COLOR16",
    0x1A2: "COLOR17",
    0x1A4: "COLOR18",
    0x1A6: "COLOR19",
    0x1A8: "COLOR20",
    0x1AA: "COLOR21",
    0x1AC: "COLOR22",
    0x1AE: "COLOR23",
    0x1B0: "COLOR24",
    0x1B2: "COLOR25",
    0x1B4: "COLOR26",
    0x1B6: "COLOR27",
    0x1B8: "COLOR28",
    0x1BA: "COLOR29",
    0x1BC: "COLOR30",
    0x1BE: "COLOR31",
    0x1C0: "HTOTAL",
    0x1C2: "HSSTOP",
    0x1C4: "HBSTRT",
    0x1C6: "HBSTOP",
    0x1C8: "VTOTAL",
    0x1CA: "VSSTOP",
    0x1CC: "VBSTRT",
    0x1CE: "VBSTOP",
    0x1D0: "SPRHSTRT",
    0x1D2: "SPRHSTOP",
    0x1D4: "BPLHSTRT",
    0x1D6: "BPLHSTOP",
    0x1D8: "HHPOSW",
    0x1DA: "HHPOSR",
    0x1DC: "BEAMCON0",
    0x1DE: "HSSTRT",
    0x1E0: "VSSTRT",
    0x1E2: "HCENTER",
    0x1E4: "DIWHIGH",
    0x1E6: "BPLHMOD",
    0x1E8: "SPRHPTH",
    0x1EA: "SPRHPTL",
    0x1EC: "BPLHPTH",
    0x1EE: "BPLHPTL",
    0x1FC: "FMODE",
}

address = 0

while True:
    try:
        line = input()

        line = line.strip()
        # Find any address that might be included
        pos = line.find(':', 0, 9)
        if pos != -1 and pos > 2:
            address = int(line[:pos], 16)
            line = line[pos + 1:]

        # Now look for the end of the memory hex
        pos = line.find("   ")
        if pos != -1:
            line = line[:pos]

        line = line.replace(" ", "")
        while len(line) >= 8:
            ir1 = int(line[0:4], 16)
            ir2 = int(line[4:8], 16)

            if ir1 & 0x0001:
                if ir2 & 0x0001:
                    print(f"0x{address:08x}:", "SKIP IF", f"0x{ir1:04x}", f"0x{ir2:04x}")
                else:
                    vpos = ir1 >> 8
                    vpos = vpos & (0x80 | (ir2 >> 8))
                    hpos = ir1 & 0xfe
                    hpos = hpos & (ir2 & 0xfe)
                    blitter = ""
                    if (ir2 & 0x8000) == 0:
                        blitter = "and blitter"
                    print(f"0x{address:08x}:", "WAIT for vpos >=", f"0x{vpos:02x}", "and hpos >=", f"0x{hpos:04x}", blitter , f"; 0x{ir1:04x} 0x{ir2:04x}")
            else:
                textReg = f"0x{ir1:04x}"
                try:
                    textReg = regToText[ir1]
                except KeyError:
                    pass
                print(f"0x{address:08x}:", "MOVE", textReg, f":= 0x{ir2:04x}")

            line = line[8:]
            address += 4

    except ValueError:
        pass

    except EOFError:
        print("Done")
        break
