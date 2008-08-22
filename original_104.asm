; Disassembly of original_104.bin (avr-gcc style)

.text
main:
   0:   rjmp    Label110
   2:   rjmp    Label1
   4:   rjmp    Label5
   6:   reti
   8:   rjmp    Label25
   a:   reti
   c:   reti
   e:   reti
  10:   reti
  12:   rjmp    Label7
  14:   rjmp    Label104
  16:   rjmp    Label46
  18:   rjmp    Label57
  1a:   rjmp    Label60
  1c:   rjmp    Label61
  1e:   reti
  20:   reti

; Referenced from offset 0x02 by rjmp
Label1:
  22:   in      r0, SREG
  24:   sbic    PINB, 3         ; 0x08 = 8
  26:   rjmp    Label2
  28:   sbi     PORTD, 7        ; 0x80 = 128
  2a:   sbi     PORTC, 3        ; 0x08 = 8

; Referenced from offset 0x26 by rjmp
Label2:
  2c:   sbis    PINB, 0         ; 0x01 = 1
  2e:   sbi     PORTC, 4        ; 0x10 = 16
  30:   sbis    PINB, 2         ; 0x04 = 4
  32:   rjmp    Label3
  34:   rjmp    Label4

; Referenced from offset 0x32 by rjmp
Label3:
  36:   lds     r19, 0x0068
  3a:   andi    r19, 0x12       ; 18
  3c:   brne    Label4
  3e:   clr     r19
  40:   sts     0x0069, r19
  44:   sts     0x006c, r19
  48:   sbi     PORTD, 6        ; 0x40 = 64
  4a:   ldi     r19, 0x05       ; 5
  4c:   sts     0x00fe, r19
  50:   lds     r19, 0x0068
  54:   ori     r19, 0x10       ; 16
  56:   andi    r19, 0xfd       ; 253
  58:   sts     0x0068, r19

; Referenced from offset 0x34 by rjmp
; Referenced from offset 0x3c by brne
Label4:
  5c:   out     SREG, r0
  5e:   reti

; Referenced from offset 0x04 by rjmp
Label5:
  60:   in      r0, SREG
  62:   in      r19, GIMSK
  64:   andi    r19, 0x7f       ; 127
  66:   out     GIMSK, r19
  68:   sbis    PINB, 3         ; 0x08 = 8
  6a:   rjmp    Label6
  6c:   cbi     PORTC, 3        ; 0x08 = 8
  6e:   in      r19, GIMSK
  70:   ori     r19, 0x80       ; 128
  72:   out     GIMSK, r19
  74:   ldi     r19, 0x80       ; 128
  76:   out     GIFR, r19
  78:   out     SREG, r0
  7a:   reti

; Referenced from offset 0x6a by rjmp
Label6:
  7c:   ori     r25, 0x02       ; 2
  7e:   lds     r19, 0x0064
  82:   ori     r19, 0x01       ; 1
  84:   sts     0x0064, r19
  88:   out     SREG, r0
  8a:   reti

; Referenced from offset 0x12 by rjmp
Label7:
  8c:   in      r0, SREG
  8e:   lds     r19, 0x007a
  92:   dec     r19
  94:   breq    Label8
  96:   sts     0x007a, r19
  9a:   rjmp    Label24

; Referenced from offset 0x94 by breq
Label8:
  9c:   ldi     r19, 0x14       ; 20
  9e:   sts     0x007a, r19
  a2:   sbrs    r22, 0          ; 0x01 = 1
  a4:   rjmp    Label9
  a6:   dec     r9
  a8:   brne    Label9
  aa:   ori     r22, 0x08       ; 8

; Referenced from offset 0xa4 by rjmp
; Referenced from offset 0xa8 by brne
Label9:
  ac:   lds     r19, 0x00ff
  b0:   andi    r19, 0x03       ; 3
  b2:   breq    Label10
  b4:   lds     r19, 0x00f4
  b8:   ori     r19, 0x08       ; 8
  ba:   sts     0x00f4, r19

; Referenced from offset 0xb2 by breq
Label10:
  be:   lds     r19, 0x008c
  c2:   sbrc    r19, 2          ; 0x04 = 4
  c4:   rjmp    Label11
  c6:   sbrc    r19, 1          ; 0x02 = 2
  c8:   rjmp    Label21
  ca:   sbrc    r19, 0          ; 0x01 = 1
  cc:   rjmp    Label16
  ce:   rjmp    Label24

; Referenced from offset 0xc4 by rjmp
Label11:
  d0:   lds     r19, 0x0075
  d4:   ori     r19, 0x02       ; 2
  d6:   sts     0x0075, r19
  da:   lds     r19, 0x006d
  de:   sbrs    r19, 0          ; 0x01 = 1
  e0:   rjmp    Label12
  e2:   sbi     PORTC, 6        ; 0x40 = 64
  e4:   rjmp    Label14

; Referenced from offset 0xe0 by rjmp
Label12:
  e6:   sbis    PINC, 6         ; 0x40 = 64
  e8:   rjmp    Label13
  ea:   cbi     PORTC, 6        ; 0x40 = 64
  ec:   rjmp    Label14

; Referenced from offset 0xe8 by rjmp
Label13:
  ee:   sbi     PORTC, 6        ; 0x40 = 64

; Referenced from offset 0xe4 by rjmp
; Referenced from offset 0xec by rjmp
Label14:
  f0:   lds     r19, 0x008a
  f4:   dec     r19
  f6:   breq    Label15
  f8:   sts     0x008a, r19
  fc:   rjmp    Label24

; Referenced from offset 0xf6 by breq
Label15:
  fe:   ldi     r19, 0x05       ; 5
 100:   sts     0x008a, r19
 104:   ori     r25, 0x50       ; 80
 106:   rjmp    Label24

; Referenced from offset 0xcc by rjmp
Label16:
 108:   lds     r19, 0x006d
 10c:   sbrs    r19, 0          ; 0x01 = 1
 10e:   rjmp    Label17
 110:   sbi     PORTC, 6        ; 0x40 = 64
 112:   rjmp    Label19

; Referenced from offset 0x10e by rjmp
Label17:
 114:   sbis    PINC, 6         ; 0x40 = 64
 116:   rjmp    Label18
 118:   cbi     PORTC, 6        ; 0x40 = 64
 11a:   rjmp    Label19

; Referenced from offset 0x116 by rjmp
Label18:
 11c:   sbi     PORTC, 6        ; 0x40 = 64

; Referenced from offset 0x112 by rjmp
; Referenced from offset 0x11a by rjmp
Label19:
 11e:   lds     r19, 0x0089
 122:   dec     r19
 124:   breq    Label20
 126:   sts     0x0089, r19
 12a:   rjmp    Label24

; Referenced from offset 0x124 by breq
Label20:
 12c:   ldi     r19, 0x0a       ; 10
 12e:   sts     0x0089, r19
 132:   ori     r25, 0x40       ; 64
 134:   rjmp    Label24

; Referenced from offset 0xc8 by rjmp
Label21:
 136:   lds     r19, 0x006d
 13a:   sbrs    r19, 0          ; 0x01 = 1
 13c:   rjmp    Label22
 13e:   sbi     PORTC, 6        ; 0x40 = 64
 140:   rjmp    Label24

; Referenced from offset 0x13c by rjmp
Label22:
 142:   sbis    PINC, 6         ; 0x40 = 64
 144:   rjmp    Label23
 146:   cbi     PORTC, 6        ; 0x40 = 64
 148:   rjmp    Label24

; Referenced from offset 0x144 by rjmp
Label23:
 14a:   sbi     PORTC, 6        ; 0x40 = 64
 14c:   rjmp    Label24

; Referenced from offset 0x9a by rjmp
; Referenced from offset 0xce by rjmp
; Referenced from offset 0xfc by rjmp
; Referenced from offset 0x106 by rjmp
; Referenced from offset 0x12a by rjmp
; Referenced from offset 0x134 by rjmp
; Referenced from offset 0x140 by rjmp
; Referenced from offset 0x148 by rjmp
; Referenced from offset 0x14c by rjmp
Label24:
 14e:   ldi     r19, 0x4c       ; 76
 150:   out     TCNT0, r19
 152:   out     SREG, r0
 154:   reti

; Referenced from offset 0x08 by rjmp
Label25:
 156:   in      r0, SREG
 158:   lds     r19, 0x008e
 15c:   sbrs    r19, 1          ; 0x02 = 2
 15e:   rjmp    Label27
 160:   lds     r19, 0x00f2
 164:   dec     r19
 166:   breq    Label26
 168:   sts     0x00f2, r19
 16c:   rjmp    Label27

; Referenced from offset 0x166 by breq
Label26:
 16e:   ldi     r19, 0xfa       ; 250
 170:   sts     0x00f2, r19
 174:   ori     r25, 0x20       ; 32

; Referenced from offset 0x15e by rjmp
; Referenced from offset 0x16c by rjmp
Label27:
 176:   lds     r19, 0x0080
 17a:   dec     r19
 17c:   breq    Label28
 17e:   sts     0x0080, r19
 182:   rjmp    Label29

; Referenced from offset 0x17c by breq
Label28:
 184:   ldi     r19, 0x7c       ; 124
 186:   sts     0x0080, r19
 18a:   ori     r25, 0x08       ; 8

; Referenced from offset 0x182 by rjmp
Label29:
 18c:   lds     r19, 0x0064
 190:   sbrs    r19, 1          ; 0x02 = 2
 192:   rjmp    Label31
 194:   lds     r19, 0x0079
 198:   dec     r19
 19a:   breq    Label30
 19c:   sts     0x0079, r19
 1a0:   rjmp    Label31

; Referenced from offset 0x19a by breq
Label30:
 1a2:   lds     r19, 0x0064
 1a6:   ori     r19, 0x04       ; 4
 1a8:   sts     0x0064, r19

; Referenced from offset 0x192 by rjmp
; Referenced from offset 0x1a0 by rjmp
Label31:
 1ac:   lds     r19, 0x006d
 1b0:   sbrs    r19, 0          ; 0x01 = 1
 1b2:   rjmp    Label33
 1b4:   lds     r19, 0x0071
 1b8:   dec     r19
 1ba:   breq    Label32
 1bc:   sts     0x0071, r19
 1c0:   rjmp    Label33

; Referenced from offset 0x1ba by breq
Label32:
 1c2:   ldi     r19, 0x64       ; 100
 1c4:   sts     0x0071, r19
 1c8:   lds     r19, 0x006d
 1cc:   ori     r19, 0x02       ; 2
 1ce:   sts     0x006d, r19

; Referenced from offset 0x1b2 by rjmp
; Referenced from offset 0x1c0 by rjmp
Label33:
 1d2:   lds     r19, 0x0065
 1d6:   sbrs    r19, 7          ; 0x80 = 128
 1d8:   rjmp    Label35
 1da:   lds     r20, 0x00fd
 1de:   dec     r20
 1e0:   breq    Label34
 1e2:   sts     0x00fd, r20
 1e6:   rjmp    Label35

; Referenced from offset 0x1e0 by breq
Label34:
 1e8:   andi    r19, 0x7f       ; 127
 1ea:   sts     0x0065, r19

; Referenced from offset 0x1d8 by rjmp
; Referenced from offset 0x1e6 by rjmp
Label35:
 1ee:   lds     r19, 0x00fe
 1f2:   dec     r19
 1f4:   breq    Label36
 1f6:   sts     0x00fe, r19
 1fa:   rjmp    Label42

; Referenced from offset 0x1f4 by breq
Label36:
 1fc:   ldi     r19, 0x08       ; 8
 1fe:   sts     0x00fe, r19
 202:   lds     r19, 0x0068
 206:   sbrs    r19, 1          ; 0x02 = 2
 208:   rjmp    Label40
 20a:   rjmp    Label37

; Referenced from offset 0x20a by rjmp
Label37:
 20c:   sbic    PINB, 2         ; 0x04 = 4
 20e:   rjmp    Label38
 210:   rjmp    Label42

; Referenced from offset 0x20e by rjmp
Label38:
 212:   sbrs    r19, 5          ; 0x20 = 32
 214:   rjmp    Label39
 216:   andi    r19, 0xdf       ; 223
 218:   andi    r19, 0xfd       ; 253
 21a:   sts     0x0068, r19
 21e:   cbi     PORTD, 6        ; 0x40 = 64
 220:   rjmp    Label42

; Referenced from offset 0x214 by rjmp
Label39:
 222:   sbrc    r19, 6          ; 0x40 = 64
 224:   rjmp    Label42
 226:   sbrc    r19, 3          ; 0x08 = 8
 228:   rjmp    Label42
 22a:   andi    r19, 0xfd       ; 253
 22c:   ori     r19, 0x08       ; 8
 22e:   sts     0x0068, r19
 232:   lds     r20, 0x006b
 236:   ori     r20, 0x80       ; 128
 238:   sts     0x006b, r20
 23c:   ori     r23, 0x04       ; 4
 23e:   cbi     PORTD, 6        ; 0x40 = 64
 240:   rjmp    Label42

; Referenced from offset 0x208 by rjmp
Label40:
 242:   sbic    PINB, 2         ; 0x04 = 4
 244:   rjmp    Label41
 246:   sbrs    r19, 4          ; 0x10 = 16
 248:   rjmp    Label42
 24a:   ori     r25, 0x04       ; 4
 24c:   rjmp    Label42

; Referenced from offset 0x244 by rjmp
Label41:
 24e:   sbrs    r19, 4          ; 0x10 = 16
 250:   rjmp    Label42
 252:   andi    r19, 0xef       ; 239
 254:   sts     0x0068, r19
 258:   cbi     PORTD, 6        ; 0x40 = 64

; Referenced from offset 0x1fa by rjmp
; Referenced from offset 0x210 by rjmp
; Referenced from offset 0x220 by rjmp
; Referenced from offset 0x224 by rjmp
; Referenced from offset 0x228 by rjmp
; Referenced from offset 0x240 by rjmp
; Referenced from offset 0x248 by rjmp
; Referenced from offset 0x24c by rjmp
; Referenced from offset 0x250 by rjmp
Label42:
 25a:   lds     r19, 0x00f5
 25e:   sbrc    r19, 1          ; 0x02 = 2
 260:   rjmp    Label43
 262:   sbrc    r19, 2          ; 0x04 = 4
 264:   rjmp    Label43
 266:   sbrc    r19, 3          ; 0x08 = 8
 268:   rjmp    Label43
 26a:   rjmp    Label45

; Referenced from offset 0x260 by rjmp
; Referenced from offset 0x264 by rjmp
; Referenced from offset 0x268 by rjmp
Label43:
 26c:   lds     r19, 0x00fc
 270:   dec     r19
 272:   breq    Label44
 274:   sts     0x00fc, r19
 278:   rjmp    Label45

; Referenced from offset 0x272 by breq
Label44:
 27a:   lds     r19, 0x00f6
 27e:   ori     r19, 0x80       ; 128
 280:   sts     0x00f6, r19

; Referenced from offset 0x26a by rjmp
; Referenced from offset 0x278 by rjmp
Label45:
 284:   ldi     r19, 0x8d       ; 141
 286:   out     TCNT2, r19
 288:   out     SREG, r0
 28a:   reti

; Referenced from offset 0x16 by rjmp
Label46:
 28c:   in      r0, SREG
 28e:   in      r19, USR
 290:   sbrc    r19, 4          ; 0x10 = 16
 292:   rjmp    Label55
 294:   in      r19, UDR
 296:   lds     r20, 0x0065
 29a:   sbrc    r20, 6          ; 0x40 = 64
 29c:   rjmp    Label56
 29e:   sbrs    r20, 7          ; 0x80 = 128
 2a0:   rjmp    Label53
 2a2:   lds     r21, 0x00ef
 2a6:   cpi     r21, 0xde       ; 222
 2a8:   breq    Label47
 2aa:   lds     r21, 0x0066
 2ae:   dec     r21
 2b0:   sts     0x0066, r21
 2b4:   rjmp    Label48

; Referenced from offset 0x2a8 by breq
Label47:
 2b6:   mov     r20, r19
 2b8:   andi    r20, 0x0f       ; 15
 2ba:   inc     r20
 2bc:   sts     0x0066, r20
 2c0:   rjmp    Label48

; Referenced from offset 0x2b4 by rjmp
; Referenced from offset 0x2c0 by rjmp
Label48:
 2c2:   lds     r30, 0x00ef
 2c6:   clr     r31
 2c8:   st      Z+, r19
 2ca:   sts     0x00ef, r30
 2ce:   cpi     r21, 0x00       ; 0
 2d0:   breq    Label49
 2d2:   rjmp    Label56

; Referenced from offset 0x2d0 by breq
Label49:
 2d4:   ldi     r30, 0xde       ; 222
 2d6:   clr     r31
 2d8:   ld      r19, Z+
 2da:   mov     r20, r19
 2dc:   andi    r19, 0x0f       ; 15
 2de:   breq    Label51

; Referenced from offset 0x2e6 by brne
Label50:
 2e0:   ld      r21, Z+
 2e2:   add     r20, r21
 2e4:   dec     r19
 2e6:   brne    Label50

; Referenced from offset 0x2de by breq
Label51:
 2e8:   ld      r21, Z+
 2ea:   cp      r20, r21
 2ec:   brne    Label52
 2ee:   lds     r20, 0x0065
 2f2:   andi    r20, 0x7f       ; 127
 2f4:   ori     r20, 0x40       ; 64
 2f6:   sts     0x0065, r20
 2fa:   rjmp    Label56

; Referenced from offset 0x2ec by brne
Label52:
 2fc:   lds     r20, 0x0065
 300:   andi    r20, 0x7f       ; 127
 302:   sts     0x0065, r20
 306:   rjmp    Label56

; Referenced from offset 0x2a0 by rjmp
Label53:
 308:   cpi     r19, 0x02       ; 2
 30a:   breq    Label54
 30c:   rjmp    Label56

; Referenced from offset 0x30a by breq
Label54:
 30e:   ldi     r21, 0x05       ; 5
 310:   sts     0x00fd, r21
 314:   ori     r20, 0x80       ; 128
 316:   sts     0x0065, r20
 31a:   ldi     r20, 0xde       ; 222
 31c:   sts     0x00ef, r20
 320:   rjmp    Label56

; Referenced from offset 0x292 by rjmp
Label55:
 322:   in      r19, UDR
 324:   lds     r19, 0x0065
 328:   andi    r19, 0x7f       ; 127
 32a:   sts     0x0065, r19
 32e:   rjmp    Label56

; Referenced from offset 0x29c by rjmp
; Referenced from offset 0x2d2 by rjmp
; Referenced from offset 0x2fa by rjmp
; Referenced from offset 0x306 by rjmp
; Referenced from offset 0x30c by rjmp
; Referenced from offset 0x320 by rjmp
; Referenced from offset 0x32e by rjmp
Label56:
 330:   out     SREG, r0
 332:   reti

; Referenced from offset 0x18 by rjmp
Label57:
 334:   in      r0, SREG
 336:   lds     r19, 0x00d1
 33a:   lds     r20, 0x00d2
 33e:   cp      r19, r20
 340:   brcs    Label59

; Referenced from offset 0x350 by rjmp
Label58:
 342:   andi    r23, 0xfe       ; 254
 344:   in      r19, UCR
 346:   andi    r19, 0x9f       ; 159
 348:   out     UCR, r19
 34a:   out     SREG, r0
 34c:   reti

; Referenced from offset 0x340 by brcs
Label59:
 34e:   sbic    PINB, 3         ; 0x08 = 8
 350:   rjmp    Label58
 352:   lds     r30, 0x00d1
 356:   clr     r31
 358:   ld      r19, Z+
 35a:   out     UDR, r19
 35c:   sts     0x00d1, r30
 360:   out     SREG, r0
 362:   reti

; Referenced from offset 0x1a by rjmp
Label60:
 364:   in      r0, SREG
 366:   in      r19, UCR
 368:   andi    r19, 0xbf       ; 191
 36a:   out     UCR, r19
 36c:   out     SREG, r0
 36e:   reti

; Referenced from offset 0x1c by rjmp
Label61:
 370:   in      r0, SREG
 372:   in      r20, ADCL
 374:   in      r21, ADCH
 376:   andi    r21, 0x03       ; 3
 378:   andi    r24, 0x7f       ; 127
 37a:   sbrc    r24, 6          ; 0x40 = 64
 37c:   rjmp    Label102
 37e:   sbrc    r24, 5          ; 0x20 = 32
 380:   rjmp    Label95
 382:   sbrc    r24, 4          ; 0x10 = 16
 384:   rjmp    Label91
 386:   sbrc    r24, 3          ; 0x08 = 8
 388:   rjmp    Label82
 38a:   sbrc    r24, 2          ; 0x04 = 4
 38c:   rjmp    Label64
 38e:   sbrc    r24, 1          ; 0x02 = 2
 390:   rjmp    Label62
 392:   sbrc    r24, 0          ; 0x01 = 1
 394:   rjmp    Label63
 396:   out     SREG, r0
 398:   reti

; Referenced from offset 0x390 by rjmp
Label62:
 39a:   sbi     PORTC, 3        ; 0x08 = 8
 39c:   sbi     PORTC, 1        ; 0x02 = 2
 39e:   andi    r24, 0xfd       ; 253
 3a0:   ori     r25, 0x01       ; 1
 3a2:   sts     0x0062, r21
 3a6:   sts     0x0063, r20
 3aa:   out     SREG, r0
 3ac:   reti

; Referenced from offset 0x394 by rjmp
Label63:
 3ae:   sbi     PORTC, 2        ; 0x04 = 4
 3b0:   sts     0x0060, r21
 3b4:   sts     0x0061, r20
 3b8:   andi    r24, 0xfe       ; 254
 3ba:   sbi     PORTC, 3        ; 0x08 = 8
 3bc:   ldi     r19, 0x07       ; 7
 3be:   sts     0x0079, r19
 3c2:   lds     r19, 0x0064
 3c6:   ori     r19, 0x02       ; 2
 3c8:   sts     0x0064, r19
 3cc:   out     SREG, r0
 3ce:   reti

; Referenced from offset 0x38c by rjmp
Label64:
 3d0:   andi    r24, 0xfb       ; 251
 3d2:   lsr     r20
 3d4:   lsr     r20
 3d6:   andi    r20, 0x3f       ; 63
 3d8:   sbrc    r21, 0          ; 0x01 = 1
 3da:   ori     r20, 0x40       ; 64
 3dc:   sbrc    r21, 1          ; 0x02 = 2
 3de:   ori     r20, 0x80       ; 128
 3e0:   cpi     r20, 0xe8       ; 232
 3e2:   brcs    Label65
 3e4:   clr     r19
 3e6:   rjmp    Label75

; Referenced from offset 0x3e2 by brcs
Label65:
 3e8:   cpi     r20, 0xd0       ; 208
 3ea:   brcs    Label66
 3ec:   ldi     r19, 0x09       ; 9
 3ee:   rjmp    Label75

; Referenced from offset 0x3ea by brcs
Label66:
 3f0:   cpi     r20, 0xb8       ; 184
 3f2:   brcs    Label67
 3f4:   ldi     r19, 0x08       ; 8
 3f6:   rjmp    Label75

; Referenced from offset 0x3f2 by brcs
Label67:
 3f8:   cpi     r20, 0xa0       ; 160
 3fa:   brcs    Label68
 3fc:   ldi     r19, 0x07       ; 7
 3fe:   rjmp    Label75

; Referenced from offset 0x3fa by brcs
Label68:
 400:   cpi     r20, 0x88       ; 136
 402:   brcs    Label69
 404:   ldi     r19, 0x06       ; 6
 406:   rjmp    Label75

; Referenced from offset 0x402 by brcs
Label69:
 408:   cpi     r20, 0x70       ; 112
 40a:   brcs    Label70
 40c:   ldi     r19, 0x05       ; 5
 40e:   rjmp    Label75

; Referenced from offset 0x40a by brcs
Label70:
 410:   cpi     r20, 0x58       ; 88
 412:   brcs    Label71
 414:   ldi     r19, 0x04       ; 4
 416:   rjmp    Label75

; Referenced from offset 0x412 by brcs
Label71:
 418:   cpi     r20, 0x40       ; 64
 41a:   brcs    Label72
 41c:   ldi     r19, 0x03       ; 3
 41e:   rjmp    Label75

; Referenced from offset 0x41a by brcs
Label72:
 420:   cpi     r20, 0x26       ; 38
 422:   brcs    Label73
 424:   ldi     r19, 0x02       ; 2
 426:   rjmp    Label75

; Referenced from offset 0x422 by brcs
Label73:
 428:   cpi     r20, 0x0c       ; 12
 42a:   brcs    Label74
 42c:   ldi     r19, 0x0a       ; 10
 42e:   rjmp    Label75

; Referenced from offset 0x42a by brcs
Label74:
 430:   ldi     r19, 0x01       ; 1

; Referenced from offset 0x3e6 by rjmp
; Referenced from offset 0x3ee by rjmp
; Referenced from offset 0x3f6 by rjmp
; Referenced from offset 0x3fe by rjmp
; Referenced from offset 0x406 by rjmp
; Referenced from offset 0x40e by rjmp
; Referenced from offset 0x416 by rjmp
; Referenced from offset 0x41e by rjmp
; Referenced from offset 0x426 by rjmp
; Referenced from offset 0x42e by rjmp
Label75:
 432:   cpi     r19, 0x00       ; 0
 434:   breq    Label76
 436:   lds     r20, 0x0069
 43a:   cp      r20, r19
 43c:   breq    Label77
 43e:   ldi     r20, 0x01       ; 1
 440:   sts     0x006c, r20
 444:   sts     0x0069, r19
 448:   out     SREG, r0
 44a:   reti

; Referenced from offset 0x434 by breq
Label76:
 44c:   sts     0x006c, r19
 450:   sts     0x0069, r19
 454:   out     SREG, r0
 456:   reti

; Referenced from offset 0x43c by breq
Label77:
 458:   lds     r20, 0x006c
 45c:   inc     r20
 45e:   sts     0x006c, r20
 462:   cpi     r20, 0x03       ; 3
 464:   brcc    Label78
 466:   out     SREG, r0
 468:   reti

; Referenced from offset 0x464 by brcc
Label78:
 46a:   sbic    PINB, 3         ; 0x08 = 8
 46c:   rjmp    Label80

; Referenced from offset 0x4ac by rjmp
Label79:
 46e:   lds     r20, 0x0068
 472:   ori     r20, 0x02       ; 2
 474:   ori     r20, 0x08       ; 8
 476:   andi    r20, 0xef       ; 239
 478:   sts     0x0068, r20
 47c:   sts     0x006b, r19
 480:   ori     r23, 0x04       ; 4
 482:   out     SREG, r0
 484:   reti

; Referenced from offset 0x46c by rjmp
Label80:
 486:   cpi     r19, 0x06       ; 6
 488:   brcs    Label81
 48a:   cpi     r19, 0x0a       ; 10
 48c:   breq    Label81
 48e:   lds     r20, 0x0068
 492:   ori     r20, 0x02       ; 2
 494:   ori     r20, 0x20       ; 32
 496:   andi    r20, 0xf7       ; 247
 498:   andi    r20, 0xef       ; 239
 49a:   sts     0x0068, r20
 49e:   out     SREG, r0
 4a0:   reti

; Referenced from offset 0x488 by brcs
; Referenced from offset 0x48c by breq
Label81:
 4a2:   lds     r20, 0x0068
 4a6:   ori     r20, 0x40       ; 64
 4a8:   sts     0x0068, r20
 4ac:   rjmp    Label79

; Referenced from offset 0x388 by rjmp
Label82:
 4ae:   andi    r24, 0xf7       ; 247
 4b0:   lds     r19, 0x007f
 4b4:   cpi     r19, 0x00       ; 0
 4b6:   brne    Label83
 4b8:   inc     r19
 4ba:   sts     0x007f, r19
 4be:   sts     0x007e, r20
 4c2:   sts     0x007d, r21
 4c6:   sts     0x0082, r20
 4ca:   sts     0x0081, r21
 4ce:   out     SREG, r0
 4d0:   reti

; Referenced from offset 0x4b6 by brne
Label83:
 4d2:   mov     r1, r20
 4d4:   mov     r2, r21
 4d6:   lds     r19, 0x0082
 4da:   sub     r20, r19
 4dc:   brcc    Label84
 4de:   lds     r19, 0x0081
 4e2:   inc     r19
 4e4:   rjmp    Label85

; Referenced from offset 0x4dc by brcc
Label84:
 4e6:   lds     r19, 0x0081

; Referenced from offset 0x4e4 by rjmp
Label85:
 4ea:   sub     r21, r19
 4ec:   brcc    Label86
 4ee:   com     r21
 4f0:   com     r20
 4f2:   inc     r20

; Referenced from offset 0x4ec by brcc
Label86:
 4f4:   cpi     r21, 0x00       ; 0
 4f6:   breq    Label88

; Referenced from offset 0x506 by rjmp
Label87:
 4f8:   clr     r19
 4fa:   sts     0x007f, r19
 4fe:   out     SREG, r0
 500:   reti

; Referenced from offset 0x4f6 by breq
Label88:
 502:   cpi     r20, 0x09       ; 9
 504:   brcs    Label89
 506:   rjmp    Label87

; Referenced from offset 0x504 by brcs
Label89:
 508:   mov     r20, r1
 50a:   mov     r21, r2
 50c:   lds     r19, 0x007e
 510:   add     r20, r19
 512:   lds     r19, 0x007d
 516:   adc     r21, r19
 518:   lds     r19, 0x007f
 51c:   inc     r19
 51e:   cpi     r19, 0x08       ; 8
 520:   breq    Label90
 522:   sts     0x007f, r19
 526:   sts     0x007e, r20
 52a:   sts     0x007d, r21
 52e:   sts     0x0082, r1
 532:   sts     0x0081, r2
 536:   out     SREG, r0
 538:   reti

; Referenced from offset 0x520 by breq
Label90:
 53a:   lsr     r20
 53c:   lsr     r20
 53e:   lsr     r20
 540:   andi    r20, 0x1f       ; 31
 542:   sbrc    r21, 0          ; 0x01 = 1
 544:   ori     r20, 0x20       ; 32
 546:   sbrc    r21, 1          ; 0x02 = 2
 548:   ori     r20, 0x40       ; 64
 54a:   sbrc    r21, 2          ; 0x04 = 4
 54c:   ori     r20, 0x80       ; 128
 54e:   lsr     r21
 550:   lsr     r21
 552:   lsr     r21
 554:   andi    r21, 0x1f       ; 31
 556:   clr     r19
 558:   sts     0x007f, r19
 55c:   sts     0x007c, r20
 560:   sts     0x007b, r21
 564:   out     SREG, r0
 566:   reti

; Referenced from offset 0x384 by rjmp
Label91:
 568:   andi    r24, 0xef       ; 239
 56a:   sts     0x0083, r20
 56e:   sts     0x0084, r21
 572:   ldi     r19, 0x99       ; 153
 574:   sub     r20, r19
 576:   brcc    Label92
 578:   ldi     r19, 0x01       ; 1
 57a:   inc     r19
 57c:   rjmp    Label93

; Referenced from offset 0x576 by brcc
Label92:
 57e:   ldi     r19, 0x01       ; 1

; Referenced from offset 0x57c by rjmp
Label93:
 580:   sub     r21, r19
 582:   brcc    Label94
 584:   lds     r19, 0x008d
 588:   inc     r19
 58a:   sts     0x008d, r19
 58e:   out     SREG, r0
 590:   reti

; Referenced from offset 0x582 by brcc
Label94:
 592:   clr     r19
 594:   sts     0x008d, r19
 598:   out     SREG, r0
 59a:   reti

; Referenced from offset 0x380 by rjmp
Label95:
 59c:   andi    r24, 0xdf       ; 223
 59e:   lsr     r20
 5a0:   lsr     r20
 5a2:   andi    r20, 0x3f       ; 63
 5a4:   sbrc    r21, 0          ; 0x01 = 1
 5a6:   ori     r20, 0x40       ; 64
 5a8:   sbrc    r21, 1          ; 0x02 = 2
 5aa:   ori     r20, 0x80       ; 128
 5ac:   lds     r19, 0x008e
 5b0:   sbrc    r19, 2          ; 0x04 = 4
 5b2:   rjmp    Label96
 5b4:   sts     0x00f1, r20
 5b8:   ori     r19, 0x04       ; 4
 5ba:   sts     0x008e, r19
 5be:   out     SREG, r0
 5c0:   reti

; Referenced from offset 0x5b2 by rjmp
Label96:
 5c2:   lds     r21, 0x00f1
 5c6:   sub     r21, r20
 5c8:   brcc    Label97
 5ca:   com     r21
 5cc:   inc     r21

; Referenced from offset 0x5c8 by brcc
Label97:
 5ce:   cpi     r21, 0x09       ; 9
 5d0:   brcs    Label98
 5d2:   rjmp    Label101

; Referenced from offset 0x5d0 by brcs
Label98:
 5d4:   lds     r21, 0x00f1
 5d8:   add     r20, r21
 5da:   brcc    Label99
 5dc:   lsr     r20
 5de:   ori     r20, 0x80       ; 128
 5e0:   rjmp    Label100

; Referenced from offset 0x5da by brcc
Label99:
 5e2:   lsr     r20

; Referenced from offset 0x5e0 by rjmp
Label100:
 5e4:   sts     0x008f, r20

; Referenced from offset 0x5d2 by rjmp
Label101:
 5e8:   lds     r19, 0x008e
 5ec:   andi    r19, 0xfb       ; 251
 5ee:   sts     0x008e, r19
 5f2:   out     SREG, r0
 5f4:   reti

; Referenced from offset 0x37c by rjmp
Label102:
 5f6:   andi    r24, 0xbf       ; 191
 5f8:   sts     0x0087, r20
 5fc:   sts     0x0088, r21
 600:   lds     r19, 0x00bb
 604:   sbrc    r19, 0          ; 0x01 = 1
 606:   rjmp    Label103
 608:   out     SREG, r0
 60a:   reti

; Referenced from offset 0x606 by rjmp
Label103:
 60c:   andi    r19, 0xfe       ; 254
 60e:   sts     0x00bb, r19
 612:   ori     r22, 0x04       ; 4
 614:   out     SREG, r0
 616:   reti

; Referenced from offset 0x14 by rjmp
Label104:
 618:   in      r0, SREG
 61a:   lds     r19, 0x00f3
 61e:   sbrs    r19, 0          ; 0x01 = 1
 620:   rjmp    Label106
 622:   lds     r20, 0x00a1
 626:   lds     r21, 0x00a2
 62a:   cp      r20, r21
 62c:   brne    Label105
 62e:   ori     r19, 0x04       ; 4
 630:   sts     0x00f3, r19
 634:   rjmp    Label109

; Referenced from offset 0x62c by brne
Label105:
 636:   lds     r30, 0x00a1
 63a:   clr     r31
 63c:   ld      r19, Z+
 63e:   sts     0x00a1, r30
 642:   out     SPDR, r19
 644:   rjmp    Label109

; Referenced from offset 0x620 by rjmp
Label106:
 646:   lds     r30, 0x00a3
 64a:   clr     r31
 64c:   in      r21, SPDR
 64e:   st      Z+, r21
 650:   sts     0x00a3, r30
 654:   sts     0x00a4, r30
 658:   lds     r20, 0x00f7
 65c:   dec     r20
 65e:   breq    Label108
 660:   sts     0x00f7, r20
 664:   lds     r20, 0x00f5
 668:   sbrc    r20, 3          ; 0x08 = 8
 66a:   rjmp    Label107
 66c:   sbrc    r20, 2          ; 0x04 = 4
 66e:   rjmp    Label107
 670:   clr     r20
 672:   out     SPDR, r20
 674:   rjmp    Label109

; Referenced from offset 0x66a by rjmp
; Referenced from offset 0x66e by rjmp
Label107:
 676:   ori     r19, 0x0c       ; 12
 678:   sts     0x00f3, r19
 67c:   rjmp    Label109

; Referenced from offset 0x65e by breq
Label108:
 67e:   ori     r19, 0x04       ; 4
 680:   sts     0x00f3, r19

; Referenced from offset 0x634 by rjmp
; Referenced from offset 0x644 by rjmp
; Referenced from offset 0x674 by rjmp
; Referenced from offset 0x67c by rjmp
Label109:
 684:   out     SREG, r0
 686:   reti

; Referenced from offset 0x00 by rjmp
Label110:
 688:   cli
 68a:   ldi     r16, 0x01       ; 1
 68c:   out     SPH, r16
 68e:   ldi     r16, 0x5f       ; 95
 690:   out     SPL, r16
 692:   in      r16, MCUSR
 694:   sbrs    r16, 0          ; 0x01 = 1
 696:   rjmp    Label111
 698:   rjmp    Label112

; Referenced from offset 0x696 by rjmp
Label111:
 69a:   sbrs    r16, 1          ; 0x02 = 2
 69c:   rjmp    Label113
 69e:   ldi     r17, 0x02       ; 2
 6a0:   sts     0x00bf, r17
 6a4:   rjmp    Label114

; Referenced from offset 0x698 by rjmp
Label112:
 6a6:   ldi     r17, 0x01       ; 1
 6a8:   sts     0x00bf, r17
 6ac:   rjmp    Label114

; Referenced from offset 0x69c by rjmp
Label113:
 6ae:   ldi     r17, 0x03       ; 3
 6b0:   sts     0x00bf, r17
 6b4:   rjmp    Label114

; Referenced from offset 0x6a4 by rjmp
; Referenced from offset 0x6ac by rjmp
; Referenced from offset 0x6b4 by rjmp
Label114:
 6b6:   clr     r16
 6b8:   out     MCUSR, r16
 6ba:   ldi     r17, 0x01       ; 1
 6bc:   out     DDRA, r17
 6be:   ldi     r17, 0x00       ; 0
 6c0:   out     PORTA, r17
 6c2:   ldi     r17, 0xb2       ; 178
 6c4:   out     DDRB, r17
 6c6:   ldi     r17, 0x1d       ; 29
 6c8:   out     PORTB, r17
 6ca:   ser     r17
 6cc:   out     DDRC, r17
 6ce:   ldi     r17, 0x6e       ; 110
 6d0:   out     PORTC, r17
 6d2:   ldi     r17, 0xf2       ; 242
 6d4:   out     DDRD, r17
 6d6:   ldi     r17, 0x25       ; 37
 6d8:   out     PORTD, r17
 6da:   ldi     r17, 0x18       ; 24
 6dc:   out     WDTCR, r17
 6de:   andi    r17, 0xfc       ; 252
 6e0:   out     WDTCR, r17
 6e2:   out     WDTCR, r16
 6e4:   out     GIMSK, r16
 6e6:   out     TIMSK, r16
 6e8:   out     MCUCR, r16
 6ea:   out     OCR1AH, r16
 6ec:   out     OCR1AL, r16
 6ee:   out     OCR1BH, r16
 6f0:   out     OCR1BL, r16
 6f2:   out     SPSR, r16
 6f4:   ldi     r17, 0xd6       ; 214
 6f6:   out     SPCR, r17
 6f8:   out     EECR, r16
 6fa:   ldi     r17, 0x98       ; 152
 6fc:   out     UCR, r17
 6fe:   ldi     r17, 0x01       ; 1
 700:   out     UBRR, r17
 702:   ldi     r17, 0x80       ; 128
 704:   out     ACSR, r17
 706:   ldi     r17, 0x9d       ; 157
 708:   out     ADCSR, r17
 70a:   ldi     r17, 0x03       ; 3
 70c:   out     TCCR2, r17
 70e:   ldi     r17, 0x8d       ; 141
 710:   out     TCNT2, r17
 712:   ldi     r17, 0x05       ; 5
 714:   out     TCCR0, r17
 716:   ldi     r17, 0x4c       ; 76
 718:   out     TCNT0, r17
 71a:   ldi     r17, 0x14       ; 20
 71c:   sts     0x007a, r17
 720:   ldi     r17, 0x7c       ; 124
 722:   sts     0x0080, r17
 726:   ldi     r23, 0x00       ; 0
 728:   ldi     r24, 0x00       ; 0
 72a:   ldi     r25, 0x00       ; 0
 72c:   ldi     r22, 0x00       ; 0
 72e:   sts     0x006c, r16
 732:   sts     0x0068, r16
 736:   sts     0x0065, r16
 73a:   sts     0x0067, r16
 73e:   sts     0x006d, r16
 742:   sts     0x0064, r16
 746:   sts     0x0075, r16
 74a:   sts     0x008c, r16
 74e:   sts     0x008e, r16
 752:   sts     0x007b, r16
 756:   sts     0x007c, r16
 75a:   sts     0x007d, r16
 75e:   sts     0x007e, r16
 762:   sts     0x0081, r16
 766:   sts     0x0082, r16
 76a:   sts     0x007f, r16
 76e:   sts     0x00f3, r16
 772:   sts     0x00f4, r16
 776:   sts     0x00f6, r16
 77a:   sts     0x00f5, r16
 77e:   sts     0x00b6, r16
 782:   sts     0x00b7, r16
 786:   sts     0x00b8, r16
 78a:   clr     r8
 78c:   sts     0x00bc, r16
 790:   sts     0x00bd, r16
 794:   sts     0x00be, r16
 798:   sts     0x00bb, r16
 79c:   ldi     r16, 0x01       ; 1
 79e:   sts     0x00ff, r16
 7a2:   ldi     r16, 0xc0       ; 192
 7a4:   out     GIFR, r16
 7a6:   ldi     r16, 0xc0       ; 192
 7a8:   out     GIMSK, r16
 7aa:   ldi     r16, 0xfd       ; 253
 7ac:   out     TIFR, r16
 7ae:   ldi     r16, 0x41       ; 65
 7b0:   out     TIMSK, r16
 7b2:   sei

; Referenced from offset 0x137c by rjmp
; Referenced from offset 0x1380 by rjmp
; Referenced from offset 0x13cc by rjmp
Label115:
 7b4:   sbrc    r23, 0          ; 0x01 = 1
 7b6:   rjmp    Label141
 7b8:   mov     r16, r23
 7ba:   andi    r16, 0xfe       ; 254
 7bc:   brne    Label116
 7be:   mov     r16, r22
 7c0:   andi    r16, 0x86       ; 134
 7c2:   brne    Label116
 7c4:   rjmp    Label141

; Referenced from offset 0x7bc by brne
; Referenced from offset 0x7c2 by brne
Label116:
 7c6:   sbis    PINB, 3         ; 0x08 = 8
 7c8:   rjmp    Label117
 7ca:   sbrc    r22, 0          ; 0x01 = 1
 7cc:   rjmp    Label118
 7ce:   andi    r22, 0xf7       ; 247
 7d0:   ldi     r16, 0x03       ; 3
 7d2:   mov     r9, r16
 7d4:   cbi     PORTC, 5        ; 0x20 = 32
 7d6:   ori     r22, 0x01       ; 1
 7d8:   sbi     PORTC, 5        ; 0x20 = 32
 7da:   rjmp    Label141

; Referenced from offset 0x7c8 by rjmp
Label117:
 7dc:   sbrs    r22, 0          ; 0x01 = 1
 7de:   rjmp    Label121

; Referenced from offset 0x7cc by rjmp
Label118:
 7e0:   sbrs    r22, 3          ; 0x08 = 8
 7e2:   rjmp    Label141
 7e4:   sbrs    r23, 2          ; 0x04 = 4
 7e6:   rjmp    Label120
 7e8:   lds     r16, 0x0068
 7ec:   sbrc    r16, 6          ; 0x40 = 64
 7ee:   rjmp    Label119
 7f0:   andi    r16, 0xf7       ; 247
 7f2:   sts     0x0068, r16
 7f6:   rjmp    Label120

; Referenced from offset 0x7ee by rjmp
Label119:
 7f8:   andi    r16, 0xb7       ; 183
 7fa:   ori     r16, 0x20       ; 32
 7fc:   sts     0x0068, r16

; Referenced from offset 0x7e6 by rjmp
; Referenced from offset 0x7f6 by rjmp
Label120:
 800:   clr     r22
 802:   clr     r23
 804:   rjmp    Label141

; Referenced from offset 0x7de by rjmp
Label121:
 806:   sbrs    r23, 4          ; 0x10 = 16
 808:   rjmp    Label122
 80a:   lds     r16, 0x00ff
 80e:   sbrs    r16, 7          ; 0x80 = 128
 810:   rjmp    Label141
 812:   andi    r16, 0x7f       ; 127
 814:   sts     0x00ff, r16
 818:   ori     r23, 0x01       ; 1
 81a:   andi    r23, 0xef       ; 239
 81c:   clr     r29
 81e:   ldi     r28, 0xc0       ; 192
 820:   sts     0x00d1, r28
 824:   ldi     r16, 0x02       ; 2
 826:   st      Y+, r16
 828:   ldi     r16, 0x09       ; 9
 82a:   mov     r17, r16
 82c:   st      Y+, r16
 82e:   ldi     r16, 0x31       ; 49
 830:   add     r17, r16
 832:   st      Y+, r16
 834:   ldi     r16, 0x2e       ; 46
 836:   add     r17, r16
 838:   st      Y+, r16
 83a:   ldi     r16, 0x30       ; 48
 83c:   add     r17, r16
 83e:   st      Y+, r16
 840:   ldi     r16, 0x34       ; 52
 842:   add     r17, r16
 844:   st      Y+, r16
 846:   lds     r16, 0x00bc
 84a:   add     r17, r16
 84c:   st      Y+, r16
 84e:   ldi     r16, 0x2e       ; 46
 850:   add     r17, r16
 852:   st      Y+, r16
 854:   lds     r16, 0x00bd
 858:   add     r17, r16
 85a:   st      Y+, r16
 85c:   lds     r16, 0x00be
 860:   add     r17, r16
 862:   st      Y+, r16
 864:   lds     r16, 0x00bf
 868:   add     r17, r16
 86a:   st      Y+, r16
 86c:   st      Y+, r17
 86e:   clr     r16
 870:   sts     0x00bf, r16
 874:   sts     0x00d2, r28
 878:   cli
 87a:   sbi     UCR, 5          ; 0x20 = 32
 87c:   sei
 87e:   rjmp    Label141

; Referenced from offset 0x808 by rjmp
Label122:
 880:   sbrs    r23, 1          ; 0x02 = 2
 882:   rjmp    Label123
 884:   ori     r23, 0x01       ; 1
 886:   andi    r23, 0xfd       ; 253
 888:   clr     r29
 88a:   ldi     r28, 0xc0       ; 192
 88c:   sts     0x00d1, r28
 890:   rcall   Function3
 892:   sts     0x00d2, r28
 896:   cli
 898:   sbi     UCR, 5          ; 0x20 = 32
 89a:   sei
 89c:   rjmp    Label141

; Referenced from offset 0x882 by rjmp
Label123:
 89e:   sbrs    r23, 2          ; 0x04 = 4
 8a0:   rjmp    Label124
 8a2:   ori     r23, 0x01       ; 1
 8a4:   andi    r23, 0xfb       ; 251
 8a6:   clr     r29
 8a8:   ldi     r28, 0xc0       ; 192
 8aa:   sts     0x00d1, r28
 8ae:   rcall   Function4
 8b0:   sts     0x00d2, r28
 8b4:   cli
 8b6:   sbi     UCR, 5          ; 0x20 = 32
 8b8:   sei
 8ba:   rjmp    Label141

; Referenced from offset 0x8a0 by rjmp
Label124:
 8bc:   sbrs    r23, 3          ; 0x08 = 8
 8be:   rjmp    Label126
 8c0:   ori     r23, 0x01       ; 1
 8c2:   andi    r23, 0xf7       ; 247
 8c4:   clr     r29
 8c6:   ldi     r28, 0xc0       ; 192
 8c8:   sts     0x00d1, r28
 8cc:   ldi     r26, 0xd5       ; 213
 8ce:   clr     r27
 8d0:   ld      r16, X+
 8d2:   ldi     r17, 0x02       ; 2
 8d4:   st      Y+, r17
 8d6:   ldi     r17, 0x40       ; 64
 8d8:   or      r17, r16
 8da:   st      Y+, r17
 8dc:   mov     r18, r17

; Referenced from offset 0x8e6 by brne
Label125:
 8de:   ld      r17, X+
 8e0:   st      Y+, r17
 8e2:   add     r18, r17
 8e4:   dec     r16
 8e6:   brne    Label125
 8e8:   st      Y+, r18
 8ea:   sts     0x00d2, r28
 8ee:   cli
 8f0:   sbi     UCR, 5          ; 0x20 = 32
 8f2:   sei
 8f4:   rjmp    Label141

; Referenced from offset 0x8be by rjmp
Label126:
 8f6:   sbrs    r22, 7          ; 0x80 = 128
 8f8:   rjmp    Label127
 8fa:   ori     r23, 0x01       ; 1
 8fc:   andi    r22, 0x7f       ; 127
 8fe:   clr     r29
 900:   ldi     r28, 0xc0       ; 192
 902:   sts     0x00d1, r28
 906:   ldi     r27, 0x01       ; 1
 908:   ldi     r26, 0x13       ; 19
 90a:   ld      r16, X+
 90c:   mov     r18, r16
 90e:   rcall   Function2
 910:   ld      r16, X+
 912:   rcall   Function2
 914:   ld      r16, X+
 916:   rcall   Function2
 918:   ldi     r16, 0x0d       ; 13
 91a:   st      Y+, r16
 91c:   sts     0x00d2, r28
 920:   cli
 922:   sbi     UCR, 5          ; 0x20 = 32
 924:   sei
 926:   rjmp    Label141

; Referenced from offset 0x8f8 by rjmp
Label127:
 928:   sbrs    r23, 6          ; 0x40 = 64
 92a:   rjmp    Label130
 92c:   ori     r23, 0x01       ; 1
 92e:   andi    r23, 0xbf       ; 191
 930:   clr     r29
 932:   ldi     r28, 0xc0       ; 192
 934:   sts     0x00d1, r28
 938:   ldi     r16, 0x02       ; 2
 93a:   st      Y+, r16
 93c:   ldi     r16, 0x95       ; 149
 93e:   lds     r18, 0x00ff
 942:   sbrc    r18, 1          ; 0x02 = 2
 944:   ldi     r16, 0x99       ; 153
 946:   sbrc    r18, 0          ; 0x01 = 1
 948:   ldi     r16, 0x99       ; 153
 94a:   mov     r17, r16
 94c:   st      Y+, r16
 94e:   ldi     r16, 0x00       ; 0
 950:   sbis    PINB, 0         ; 0x01 = 1
 952:   ldi     r16, 0x01       ; 1
 954:   add     r17, r16
 956:   st      Y+, r16
 958:   ldi     r16, 0x05       ; 5
 95a:   add     r17, r16
 95c:   st      Y+, r16
 95e:   cli
 960:   lds     r16, 0x007c
 964:   add     r17, r16
 966:   st      Y+, r16
 968:   lds     r16, 0x007b
 96c:   add     r17, r16
 96e:   st      Y+, r16
 970:   sei
 972:   ldi     r16, 0x00       ; 0
 974:   lds     r18, 0x008c
 978:   sbrc    r18, 0          ; 0x01 = 1
 97a:   ldi     r16, 0x08       ; 8
 97c:   sbrc    r18, 1          ; 0x02 = 2
 97e:   ldi     r16, 0x08       ; 8
 980:   sbrc    r18, 2          ; 0x04 = 4
 982:   ldi     r16, 0x08       ; 8
 984:   lds     r18, 0x00b8
 988:   sbrc    r18, 4          ; 0x10 = 16
 98a:   ldi     r16, 0x08       ; 8
 98c:   lds     r18, 0x0075
 990:   sbrc    r18, 6          ; 0x40 = 64
 992:   ori     r16, 0x40       ; 64
 994:   add     r17, r16
 996:   st      Y+, r16
 998:   lds     r18, 0x00ff
 99c:   sbrc    r18, 1          ; 0x02 = 2
 99e:   rjmp    Label128
 9a0:   sbrc    r18, 0          ; 0x01 = 1
 9a2:   rjmp    Label128
 9a4:   rjmp    Label129

; Referenced from offset 0x99e by rjmp
; Referenced from offset 0x9a2 by rjmp
Label128:
 9a6:   lds     r16, 0x00b6
 9aa:   add     r17, r16
 9ac:   st      Y+, r16
 9ae:   lds     r16, 0x00b7
 9b2:   add     r17, r16
 9b4:   st      Y+, r16
 9b6:   lds     r16, 0x00b8
 9ba:   andi    r16, 0xef       ; 239
 9bc:   sbic    PINB, 0         ; 0x01 = 1
 9be:   andi    r16, 0xf7       ; 247
 9c0:   add     r17, r16
 9c2:   st      Y+, r16
 9c4:   mov     r16, r8
 9c6:   add     r17, r16
 9c8:   st      Y+, r16

; Referenced from offset 0x9a4 by rjmp
Label129:
 9ca:   st      Y+, r17
 9cc:   sts     0x00d2, r28
 9d0:   cli
 9d2:   sbi     UCR, 5          ; 0x20 = 32
 9d4:   sei
 9d6:   rjmp    Label141

; Referenced from offset 0x92a by rjmp
Label130:
 9d8:   sbrs    r23, 7          ; 0x80 = 128
 9da:   rjmp    Label137
 9dc:   ori     r23, 0x01       ; 1
 9de:   clr     r29
 9e0:   ldi     r28, 0xc0       ; 192
 9e2:   sts     0x00d1, r28
 9e6:   ldi     r16, 0x02       ; 2
 9e8:   st      Y+, r16
 9ea:   lds     r17, 0x0067
 9ee:   sbrc    r17, 0          ; 0x01 = 1
 9f0:   rjmp    Label131
 9f2:   sbrc    r17, 1          ; 0x02 = 2
 9f4:   rjmp    Label132
 9f6:   sbrc    r17, 2          ; 0x04 = 4
 9f8:   rjmp    Label133
 9fa:   sbrc    r17, 3          ; 0x08 = 8
 9fc:   rjmp    Label134

; Referenced from offset 0x9f0 by rjmp
Label131:
 9fe:   ldi     r16, 0xd0       ; 208
 a00:   andi    r17, 0xfe       ; 254
 a02:   rjmp    Label135

; Referenced from offset 0x9f4 by rjmp
Label132:
 a04:   ldi     r16, 0x80       ; 128
 a06:   andi    r17, 0xfd       ; 253
 a08:   rjmp    Label135

; Referenced from offset 0x9f8 by rjmp
Label133:
 a0a:   ldi     r16, 0x50       ; 80
 a0c:   andi    r17, 0xfb       ; 251
 a0e:   rjmp    Label135

; Referenced from offset 0x9fc by rjmp
Label134:
 a10:   ldi     r16, 0xc0       ; 192
 a12:   andi    r17, 0xf7       ; 247
 a14:   rjmp    Label135

; Referenced from offset 0xa02 by rjmp
; Referenced from offset 0xa08 by rjmp
; Referenced from offset 0xa0e by rjmp
; Referenced from offset 0xa14 by rjmp
Label135:
 a16:   st      Y+, r16
 a18:   st      Y+, r16
 a1a:   sts     0x00d2, r28
 a1e:   sts     0x0067, r17
 a22:   cpi     r17, 0x00       ; 0
 a24:   brne    Label136
 a26:   andi    r23, 0x7f       ; 127

; Referenced from offset 0xa24 by brne
Label136:
 a28:   cli
 a2a:   sbi     UCR, 5          ; 0x20 = 32
 a2c:   sei
 a2e:   rjmp    Label141

; Referenced from offset 0x9da by rjmp
Label137:
 a30:   sbrs    r23, 5          ; 0x20 = 32
 a32:   rjmp    Label138
 a34:   ori     r23, 0x01       ; 1
 a36:   andi    r23, 0xdf       ; 223
 a38:   clr     r29
 a3a:   ldi     r28, 0xc0       ; 192
 a3c:   sts     0x00d1, r28
 a40:   ldi     r16, 0x02       ; 2
 a42:   st      Y+, r16
 a44:   ldi     r16, 0xd1       ; 209
 a46:   st      Y+, r16
 a48:   mov     r17, r16
 a4a:   lds     r16, 0x008f
 a4e:   add     r17, r16
 a50:   st      Y+, r16
 a52:   st      Y+, r17
 a54:   sts     0x00d2, r28
 a58:   cli
 a5a:   sbi     UCR, 5          ; 0x20 = 32
 a5c:   sei
 a5e:   rjmp    Label141

; Referenced from offset 0xa32 by rjmp
Label138:
 a60:   sbrs    r22, 1          ; 0x02 = 2
 a62:   rjmp    Label140
 a64:   ori     r23, 0x01       ; 1
 a66:   andi    r22, 0xfd       ; 253
 a68:   clr     r29
 a6a:   ldi     r28, 0xc0       ; 192
 a6c:   sts     0x00d1, r28
 a70:   ldi     r27, 0x01       ; 1
 a72:   ldi     r26, 0x00       ; 0
 a74:   lds     r18, 0x00f8
 a78:   ldi     r16, 0x02       ; 2
 a7a:   st      Y+, r16
 a7c:   ldi     r16, 0xb0       ; 176
 a7e:   or      r16, r18
 a80:   st      Y+, r16
 a82:   mov     r17, r16

; Referenced from offset 0xa8c by brne
Label139:
 a84:   ld      r16, X+
 a86:   st      Y+, r16
 a88:   add     r17, r16
 a8a:   dec     r18
 a8c:   brne    Label139
 a8e:   st      Y+, r17
 a90:   sts     0x00d2, r28
 a94:   cli
 a96:   sbi     UCR, 5          ; 0x20 = 32
 a98:   sei
 a9a:   rjmp    Label141

; Referenced from offset 0xa62 by rjmp
Label140:
 a9c:   sbrs    r22, 2          ; 0x04 = 4
 a9e:   rjmp    Label141
 aa0:   ori     r23, 0x01       ; 1
 aa2:   andi    r22, 0xfb       ; 251
 aa4:   clr     r29
 aa6:   ldi     r28, 0xc0       ; 192
 aa8:   sts     0x00d1, r28
 aac:   ldi     r16, 0x02       ; 2
 aae:   st      Y+, r16
 ab0:   ldi     r16, 0x62       ; 98
 ab2:   st      Y+, r16
 ab4:   mov     r17, r16
 ab6:   cli
 ab8:   lds     r16, 0x0087
 abc:   st      Y+, r16
 abe:   add     r17, r16
 ac0:   lds     r16, 0x0088
 ac4:   sei
 ac6:   st      Y+, r16
 ac8:   add     r17, r16
 aca:   st      Y+, r17
 acc:   sts     0x00d2, r28
 ad0:   cli
 ad2:   sbi     UCR, 5          ; 0x20 = 32
 ad4:   sei
 ad6:   rjmp    Label141

; Referenced from offset 0x7b6 by rjmp
; Referenced from offset 0x7c4 by rjmp
; Referenced from offset 0x7da by rjmp
; Referenced from offset 0x7e2 by rjmp
; Referenced from offset 0x804 by rjmp
; Referenced from offset 0x810 by rjmp
; Referenced from offset 0x87e by rjmp
; Referenced from offset 0x89c by rjmp
; Referenced from offset 0x8ba by rjmp
; Referenced from offset 0x8f4 by rjmp
; Referenced from offset 0x926 by rjmp
; Referenced from offset 0x9d6 by rjmp
; Referenced from offset 0xa2e by rjmp
; Referenced from offset 0xa5e by rjmp
; Referenced from offset 0xa9a by rjmp
; Referenced from offset 0xa9e by rjmp
; Referenced from offset 0xad6 by rjmp
Label141:
 ad8:   sbrc    r24, 7          ; 0x80 = 128
 ada:   rjmp    Label149
 adc:   sbic    ADCSR, 7        ; 0x80 = 128
 ade:   rjmp    Label142
 ae0:   ldi     r16, 0x9d       ; 157
 ae2:   out     ADCSR, r16

; Referenced from offset 0xade by rjmp
Label142:
 ae4:   sbrs    r25, 0          ; 0x01 = 1
 ae6:   rjmp    Label143
 ae8:   ori     r24, 0x81       ; 129
 aea:   andi    r25, 0xfe       ; 254
 aec:   cbi     PORTC, 2        ; 0x04 = 4
 aee:   sbi     PORTC, 3        ; 0x08 = 8
 af0:   cbi     PORTC, 0        ; 0x01 = 1
 af2:   sbi     PORTC, 1        ; 0x02 = 2
 af4:   rcall   Function1
 af6:   ldi     r16, 0x07       ; 7
 af8:   out     ADMUX, r16
 afa:   ldi     r16, 0xdd       ; 221
 afc:   out     ADCSR, r16
 afe:   rjmp    Label149

; Referenced from offset 0xae6 by rjmp
Label143:
 b00:   sbrs    r25, 1          ; 0x02 = 2
 b02:   rjmp    Label144
 b04:   ori     r24, 0x82       ; 130
 b06:   andi    r25, 0xfd       ; 253
 b08:   sbi     PORTC, 2        ; 0x04 = 4
 b0a:   cbi     PORTC, 3        ; 0x08 = 8
 b0c:   sbi     PORTC, 0        ; 0x01 = 1
 b0e:   cbi     PORTC, 1        ; 0x02 = 2
 b10:   rcall   Function1
 b12:   ldi     r16, 0x06       ; 6
 b14:   out     ADMUX, r16
 b16:   ldi     r16, 0xdd       ; 221
 b18:   out     ADCSR, r16
 b1a:   rjmp    Label149

; Referenced from offset 0xb02 by rjmp
Label144:
 b1c:   sbrs    r25, 2          ; 0x04 = 4
 b1e:   rjmp    Label145
 b20:   ori     r24, 0x84       ; 132
 b22:   andi    r25, 0xfb       ; 251
 b24:   ldi     r16, 0x05       ; 5
 b26:   out     ADMUX, r16
 b28:   ldi     r16, 0xdd       ; 221
 b2a:   out     ADCSR, r16
 b2c:   rjmp    Label149

; Referenced from offset 0xb1e by rjmp
Label145:
 b2e:   sbrs    r25, 3          ; 0x08 = 8
 b30:   rjmp    Label146
 b32:   ori     r24, 0x88       ; 136
 b34:   andi    r25, 0xf7       ; 247
 b36:   ldi     r16, 0x04       ; 4
 b38:   out     ADMUX, r16
 b3a:   ldi     r16, 0xdd       ; 221
 b3c:   out     ADCSR, r16
 b3e:   rjmp    Label149

; Referenced from offset 0xb30 by rjmp
Label146:
 b40:   sbrs    r25, 4          ; 0x10 = 16
 b42:   rjmp    Label147
 b44:   ori     r24, 0x90       ; 144
 b46:   andi    r25, 0xef       ; 239
 b48:   ldi     r16, 0x03       ; 3
 b4a:   out     ADMUX, r16
 b4c:   ldi     r16, 0xdd       ; 221
 b4e:   out     ADCSR, r16
 b50:   rjmp    Label149

; Referenced from offset 0xb42 by rjmp
Label147:
 b52:   sbrs    r25, 5          ; 0x20 = 32
 b54:   rjmp    Label148
 b56:   ori     r24, 0xa0       ; 160
 b58:   andi    r25, 0xdf       ; 223
 b5a:   ldi     r16, 0x02       ; 2
 b5c:   out     ADMUX, r16
 b5e:   ldi     r16, 0xdd       ; 221
 b60:   out     ADCSR, r16
 b62:   rjmp    Label149

; Referenced from offset 0xb54 by rjmp
Label148:
 b64:   sbrs    r25, 6          ; 0x40 = 64
 b66:   rjmp    Label149
 b68:   ori     r24, 0xc0       ; 192
 b6a:   andi    r25, 0xbf       ; 191
 b6c:   ldi     r16, 0x01       ; 1
 b6e:   out     ADMUX, r16
 b70:   ldi     r16, 0xdd       ; 221
 b72:   out     ADCSR, r16
 b74:   rjmp    Label149

; Referenced from offset 0xada by rjmp
; Referenced from offset 0xafe by rjmp
; Referenced from offset 0xb1a by rjmp
; Referenced from offset 0xb2c by rjmp
; Referenced from offset 0xb3e by rjmp
; Referenced from offset 0xb50 by rjmp
; Referenced from offset 0xb62 by rjmp
; Referenced from offset 0xb66 by rjmp
; Referenced from offset 0xb74 by rjmp
Label149:
 b76:   lds     r16, 0x006d
 b7a:   sbrs    r16, 0          ; 0x01 = 1
 b7c:   rjmp    Label156
 b7e:   sbrs    r16, 1          ; 0x02 = 2
 b80:   rjmp    Label156
 b82:   andi    r16, 0xfd       ; 253
 b84:   sts     0x006d, r16
 b88:   lds     r16, 0x0074
 b8c:   dec     r16
 b8e:   breq    Label150
 b90:   sts     0x0074, r16
 b94:   rjmp    Label152

; Referenced from offset 0xb8e by breq
Label150:
 b96:   sbis    PINB, 4         ; 0x10 = 16
 b98:   rjmp    Label151
 b9a:   cbi     PORTB, 4        ; 0x10 = 16
 b9c:   lds     r16, 0x006f
 ba0:   sts     0x0074, r16
 ba4:   rjmp    Label152

; Referenced from offset 0xb98 by rjmp
Label151:
 ba6:   sbi     PORTB, 4        ; 0x10 = 16
 ba8:   lds     r16, 0x0070
 bac:   sts     0x0074, r16
 bb0:   rjmp    Label152

; Referenced from offset 0xb94 by rjmp
; Referenced from offset 0xba4 by rjmp
; Referenced from offset 0xbb0 by rjmp
Label152:
 bb2:   lds     r16, 0x006d
 bb6:   sbrc    r16, 2          ; 0x04 = 4
 bb8:   rjmp    Label156
 bba:   lds     r16, 0x0072
 bbe:   dec     r16
 bc0:   breq    Label153
 bc2:   sts     0x0072, r16
 bc6:   rjmp    Label156

; Referenced from offset 0xbc0 by breq
Label153:
 bc8:   ldi     r16, 0x32       ; 50
 bca:   sts     0x0072, r16
 bce:   lds     r16, 0x0073
 bd2:   dec     r16
 bd4:   breq    Label154
 bd6:   sts     0x0073, r16
 bda:   rjmp    Label156

; Referenced from offset 0xbd4 by breq
Label154:
 bdc:   ldi     r16, 0x0c       ; 12
 bde:   sts     0x0073, r16
 be2:   lds     r16, 0x006e
 be6:   dec     r16
 be8:   breq    Label155
 bea:   sts     0x006e, r16
 bee:   rjmp    Label156

; Referenced from offset 0xbe8 by breq
Label155:
 bf0:   lds     r16, 0x006d
 bf4:   andi    r16, 0xfc       ; 252
 bf6:   sts     0x006d, r16
 bfa:   sbi     PORTB, 4        ; 0x10 = 16
 bfc:   rjmp    Label156

; Referenced from offset 0xb7c by rjmp
; Referenced from offset 0xb80 by rjmp
; Referenced from offset 0xbb8 by rjmp
; Referenced from offset 0xbc6 by rjmp
; Referenced from offset 0xbda by rjmp
; Referenced from offset 0xbee by rjmp
; Referenced from offset 0xbfc by rjmp
Label156:
 bfe:   lds     r16, 0x0075
 c02:   sbrs    r16, 0          ; 0x01 = 1
 c04:   rjmp    Label182
 c06:   sbic    PINB, 0         ; 0x01 = 1
 c08:   rjmp    Label181
 c0a:   lds     r16, 0x008d
 c0e:   cpi     r16, 0x02       ; 2
 c10:   brcs    Label157
 c12:   lds     r16, 0x0075
 c16:   ori     r16, 0x08       ; 8
 c18:   sts     0x0075, r16
 c1c:   rjmp    Label171

; Referenced from offset 0xc10 by brcs
Label157:
 c1e:   lds     r16, 0x0075
 c22:   sbrc    r16, 1          ; 0x02 = 2
 c24:   rjmp    Label158
 c26:   rjmp    Label192

; Referenced from offset 0xc24 by rjmp
Label158:
 c28:   andi    r16, 0xfd       ; 253
 c2a:   sts     0x0075, r16
 c2e:   lds     r16, 0x00ba
 c32:   dec     r16
 c34:   breq    Label159
 c36:   sts     0x00ba, r16
 c3a:   rjmp    Label163

; Referenced from offset 0xc34 by breq
Label159:
 c3c:   ldi     r16, 0x0a       ; 10
 c3e:   sts     0x00ba, r16
 c42:   cli
 c44:   lds     r16, 0x0087
 c48:   lds     r17, 0x0088
 c4c:   sei
 c4e:   ldi     r18, 0x7b       ; 123
 c50:   sub     r16, r18
 c52:   brcc    Label160
 c54:   ldi     r18, 0x00       ; 0
 c56:   inc     r18
 c58:   rjmp    Label161

; Referenced from offset 0xc52 by brcc
Label160:
 c5a:   ldi     r18, 0x00       ; 0

; Referenced from offset 0xc58 by rjmp
Label161:
 c5c:   sub     r17, r18
 c5e:   brcs    Label162
 c60:   rcall   Function13
 c62:   rjmp    Label163

; Referenced from offset 0xc5e by brcs
Label162:
 c64:   lds     r16, 0x0075
 c68:   ori     r16, 0x20       ; 32
 c6a:   sts     0x0075, r16
 c6e:   rjmp    Label171

; Referenced from offset 0xc3a by rjmp
; Referenced from offset 0xc62 by rjmp
Label163:
 c70:   lds     r16, 0x0076
 c74:   dec     r16
 c76:   breq    Label164
 c78:   sts     0x0076, r16
 c7c:   rjmp    Label192

; Referenced from offset 0xc76 by breq
Label164:
 c7e:   ldi     r16, 0x3c       ; 60
 c80:   sts     0x0076, r16
 c84:   lds     r16, 0x0077
 c88:   dec     r16
 c8a:   breq    Label165
 c8c:   sts     0x0077, r16
 c90:   rjmp    Label192

; Referenced from offset 0xc8a by breq
Label165:
 c92:   ldi     r16, 0x3c       ; 60
 c94:   sts     0x0077, r16
 c98:   lds     r16, 0x0078
 c9c:   dec     r16
 c9e:   breq    Label166
 ca0:   sts     0x0078, r16
 ca4:   cpi     r16, 0x07       ; 7
 ca6:   breq    Label167
 ca8:   rjmp    Label192

; Referenced from offset 0xc9e by breq
Label166:
 caa:   lds     r16, 0x0075
 cae:   ori     r16, 0x10       ; 16
 cb0:   sts     0x0075, r16
 cb4:   rjmp    Label171

; Referenced from offset 0xca6 by breq
Label167:
 cb6:   cli
 cb8:   lds     r16, 0x007c
 cbc:   lds     r17, 0x007b
 cc0:   sei
 cc2:   ldi     r18, 0xaa       ; 170
 cc4:   sub     r16, r18
 cc6:   brcc    Label168
 cc8:   ldi     r18, 0x02       ; 2
 cca:   inc     r18
 ccc:   rjmp    Label169

; Referenced from offset 0xcc6 by brcc
Label168:
 cce:   ldi     r18, 0x02       ; 2

; Referenced from offset 0xccc by rjmp
Label169:
 cd0:   sub     r17, r18
 cd2:   brcs    Label170
 cd4:   rjmp    Label192

; Referenced from offset 0xcd2 by brcs
Label170:
 cd6:   lds     r16, 0x0075
 cda:   ori     r16, 0x04       ; 4
 cdc:   sts     0x0075, r16
 ce0:   rjmp    Label171

; Referenced from offset 0xc1c by rjmp
; Referenced from offset 0xc6e by rjmp
; Referenced from offset 0xcb4 by rjmp
; Referenced from offset 0xce0 by rjmp
Label171:
 ce2:   lds     r16, 0x0075
 ce6:   andi    r16, 0xfc       ; 252
 ce8:   sts     0x0075, r16
 cec:   lds     r16, 0x0075
 cf0:   sbrc    r16, 3          ; 0x08 = 8
 cf2:   rjmp    Label172
 cf4:   sbrc    r16, 4          ; 0x10 = 16
 cf6:   rjmp    Label173
 cf8:   sbrc    r16, 2          ; 0x04 = 4
 cfa:   rjmp    Label175
 cfc:   sbrc    r16, 5          ; 0x20 = 32
 cfe:   rjmp    Label174
 d00:   rjmp    Label192

; Referenced from offset 0xcf2 by rjmp
Label172:
 d02:   andi    r16, 0xf7       ; 247
 d04:   sts     0x0075, r16
 d08:   rjmp    Label176

; Referenced from offset 0xcf6 by rjmp
Label173:
 d0a:   andi    r16, 0xef       ; 239
 d0c:   sts     0x0075, r16
 d10:   rjmp    Label176

; Referenced from offset 0xcfe by rjmp
Label174:
 d12:   andi    r16, 0xdf       ; 223
 d14:   sts     0x0075, r16

; Referenced from offset 0xcfa by rjmp
Label175:
 d18:   rjmp    Label180

; Referenced from offset 0xd08 by rjmp
; Referenced from offset 0xd10 by rjmp
Label176:
 d1a:   cli
 d1c:   lds     r16, 0x007c
 d20:   lds     r17, 0x007b
 d24:   sei
 d26:   ldi     r18, 0x99       ; 153
 d28:   sub     r16, r18
 d2a:   brcc    Label177
 d2c:   ldi     r18, 0x03       ; 3
 d2e:   inc     r18
 d30:   rjmp    Label178

; Referenced from offset 0xd2a by brcc
Label177:
 d32:   ldi     r18, 0x03       ; 3

; Referenced from offset 0xd30 by rjmp
Label178:
 d34:   sub     r17, r18
 d36:   brcc    Label179
 d38:   rjmp    Label180

; Referenced from offset 0xd36 by brcc
Label179:
 d3a:   lds     r16, 0x0075
 d3e:   ori     r16, 0x80       ; 128
 d40:   ori     r16, 0x40       ; 64
 d42:   sts     0x0075, r16
 d46:   rjmp    Label180

; Referenced from offset 0xd18 by rjmp
; Referenced from offset 0xd38 by rjmp
; Referenced from offset 0xd46 by rjmp
Label180:
 d48:   sbi     PORTC, 6        ; 0x40 = 64
 d4a:   cbi     PORTB, 1        ; 0x02 = 2
 d4c:   lds     r16, 0x008c
 d50:   andi    r16, 0xfb       ; 251
 d52:   ori     r16, 0x08       ; 8
 d54:   sts     0x008c, r16
 d58:   rjmp    Label192

; Referenced from offset 0xc08 by rjmp
Label181:
 d5a:   clr     r16
 d5c:   sts     0x008c, r16
 d60:   sts     0x0075, r16
 d64:   cbi     PORTB, 1        ; 0x02 = 2
 d66:   sbi     PORTC, 6        ; 0x40 = 64
 d68:   rjmp    Label192

; Referenced from offset 0xc04 by rjmp
Label182:
 d6a:   sbic    PINB, 0         ; 0x01 = 1
 d6c:   rjmp    Label191
 d6e:   lds     r16, 0x0075
 d72:   sbrc    r16, 2          ; 0x04 = 4
 d74:   rjmp    Label192
 d76:   lds     r16, 0x008c
 d7a:   sbrc    r16, 3          ; 0x08 = 8
 d7c:   rjmp    Label183
 d7e:   sbrc    r16, 1          ; 0x02 = 2
 d80:   rjmp    Label190
 d82:   sbrc    r16, 0          ; 0x01 = 1
 d84:   rjmp    Label188
 d86:   clr     r16
 d88:   sts     0x0087, r16
 d8c:   sts     0x0088, r16
 d90:   ldi     r16, 0x03       ; 3
 d92:   sts     0x0089, r16
 d96:   lds     r16, 0x008c
 d9a:   ori     r16, 0x01       ; 1
 d9c:   sts     0x008c, r16
 da0:   rjmp    Label188

; Referenced from offset 0xd7c by rjmp
Label183:
 da2:   lds     r16, 0x0075
 da6:   sbrs    r16, 7          ; 0x80 = 128
 da8:   rjmp    Label184
 daa:   lds     r16, 0x006d
 dae:   sbrs    r16, 0          ; 0x01 = 1
 db0:   cbi     PORTC, 6        ; 0x40 = 64

; Referenced from offset 0xda8 by rjmp
Label184:
 db2:   cli
 db4:   lds     r16, 0x007c
 db8:   lds     r17, 0x007b
 dbc:   sei
 dbe:   ldi     r18, 0x8b       ; 139
 dc0:   sub     r16, r18
 dc2:   brcc    Label185
 dc4:   ldi     r18, 0x03       ; 3
 dc6:   inc     r18
 dc8:   rjmp    Label186

; Referenced from offset 0xdc2 by brcc
Label185:
 dca:   ldi     r18, 0x03       ; 3

; Referenced from offset 0xdc8 by rjmp
Label186:
 dcc:   sub     r17, r18
 dce:   brcs    Label187
 dd0:   rjmp    Label192

; Referenced from offset 0xdce by brcs
Label187:
 dd2:   lds     r16, 0x0075
 dd6:   andi    r16, 0x7f       ; 127
 dd8:   andi    r16, 0xbf       ; 191
 dda:   sts     0x0075, r16
 dde:   sbi     PORTC, 6        ; 0x40 = 64
 de0:   clr     r16
 de2:   sts     0x0087, r16
 de6:   sts     0x0088, r16
 dea:   ldi     r16, 0x03       ; 3
 dec:   sts     0x0089, r16
 df0:   lds     r16, 0x008c
 df4:   ori     r16, 0x01       ; 1
 df6:   andi    r16, 0xf7       ; 247
 df8:   sts     0x008c, r16
 dfc:   rjmp    Label188

; Referenced from offset 0xd84 by rjmp
; Referenced from offset 0xda0 by rjmp
; Referenced from offset 0xdfc by rjmp
Label188:
 dfe:   cli
 e00:   lds     r16, 0x0087
 e04:   lds     r17, 0x0088
 e08:   sei
 e0a:   ldi     r18, 0x8f       ; 143
 e0c:   sub     r16, r18
 e0e:   brcc    Label189
 e10:   ldi     r18, 0x00       ; 0
 e12:   inc     r18
 e14:   sub     r17, r18
 e16:   brcs    Label192

; Referenced from offset 0xe0e by brcc
Label189:
 e18:   lds     r16, 0x008c
 e1c:   andi    r16, 0xfe       ; 254
 e1e:   ori     r16, 0x02       ; 2
 e20:   sts     0x008c, r16
 e24:   rjmp    Label190

; Referenced from offset 0xd80 by rjmp
; Referenced from offset 0xe24 by rjmp
Label190:
 e26:   rcall   Function13
 e28:   ldi     r16, 0x3c       ; 60
 e2a:   sts     0x0076, r16
 e2e:   ldi     r16, 0x3c       ; 60
 e30:   sts     0x0077, r16
 e34:   ldi     r16, 0x08       ; 8
 e36:   sts     0x0078, r16
 e3a:   clr     r16
 e3c:   sts     0x008d, r16
 e40:   ldi     r16, 0x05       ; 5
 e42:   sts     0x008a, r16
 e46:   ldi     r16, 0x0a       ; 10
 e48:   sts     0x00ba, r16
 e4c:   sbi     PORTA, 0        ; 0x01 = 1
 e4e:   sbi     PORTB, 1        ; 0x02 = 2
 e50:   ldi     r16, 0x01       ; 1
 e52:   sts     0x0075, r16
 e56:   lds     r16, 0x008c
 e5a:   andi    r16, 0xfd       ; 253
 e5c:   ori     r16, 0x04       ; 4
 e5e:   sts     0x008c, r16
 e62:   rjmp    Label192

; Referenced from offset 0xd6c by rjmp
Label191:
 e64:   clr     r16
 e66:   sts     0x0075, r16
 e6a:   sts     0x008c, r16
 e6e:   sbi     PORTC, 6        ; 0x40 = 64
 e70:   rjmp    Label192

; Referenced from offset 0xc26 by rjmp
; Referenced from offset 0xc7c by rjmp
; Referenced from offset 0xc90 by rjmp
; Referenced from offset 0xca8 by rjmp
; Referenced from offset 0xcd4 by rjmp
; Referenced from offset 0xd00 by rjmp
; Referenced from offset 0xd58 by rjmp
; Referenced from offset 0xd68 by rjmp
; Referenced from offset 0xd74 by rjmp
; Referenced from offset 0xdd0 by rjmp
; Referenced from offset 0xe16 by brcs
; Referenced from offset 0xe62 by rjmp
; Referenced from offset 0xe70 by rjmp
Label192:
 e72:   lds     r16, 0x0064
 e76:   sbrs    r16, 1          ; 0x02 = 2
 e78:   rjmp    Label196
 e7a:   sbrs    r16, 2          ; 0x04 = 4
 e7c:   rjmp    Label196
 e7e:   sbic    PINB, 3         ; 0x08 = 8
 e80:   rjmp    Label193
 e82:   sbic    PIND, 3         ; 0x08 = 8
 e84:   rjmp    Label194
 e86:   andi    r16, 0xf9       ; 249
 e88:   sts     0x0064, r16
 e8c:   cbi     PORTC, 3        ; 0x08 = 8
 e8e:   ori     r25, 0x02       ; 2
 e90:   ori     r23, 0x02       ; 2
 e92:   rjmp    Label196

; Referenced from offset 0xe80 by rjmp
Label193:
 e94:   andi    r16, 0xf8       ; 248
 e96:   sts     0x0064, r16
 e9a:   rjmp    Label195

; Referenced from offset 0xe84 by rjmp
Label194:
 e9c:   andi    r16, 0xf8       ; 248
 e9e:   sts     0x0064, r16
 ea2:   ori     r23, 0x02       ; 2

; Referenced from offset 0xe9a by rjmp
Label195:
 ea4:   in      r16, GIMSK
 ea6:   ori     r16, 0x80       ; 128
 ea8:   out     GIMSK, r16
 eaa:   ldi     r16, 0x80       ; 128
 eac:   out     GIFR, r16

; Referenced from offset 0xe78 by rjmp
; Referenced from offset 0xe7c by rjmp
; Referenced from offset 0xe92 by rjmp
Label196:
 eae:   lds     r16, 0x00f3
 eb2:   sbrc    r16, 7          ; 0x80 = 128
 eb4:   rjmp    Label205
 eb6:   lds     r17, 0x00f4
 eba:   andi    r17, 0x0f       ; 15
 ebc:   brne    Label197
 ebe:   rjmp    Label205

; Referenced from offset 0xebc by brne
Label197:
 ec0:   sbis    SPCR, 6         ; 0x40 = 64
 ec2:   sbi     SPCR, 6         ; 0x40 = 64
 ec4:   lds     r18, 0x00f4
 ec8:   sbrs    r18, 1          ; 0x02 = 2
 eca:   rjmp    Label198
 ecc:   ori     r16, 0x81       ; 129
 ece:   sts     0x00f3, r16
 ed2:   andi    r18, 0xfd       ; 253
 ed4:   sts     0x00f4, r18
 ed8:   lds     r17, 0x00f6
 edc:   andi    r17, 0x7f       ; 127
 ede:   ori     r17, 0x01       ; 1
 ee0:   sts     0x00f6, r17
 ee4:   ldi     r17, 0x11       ; 17
 ee6:   sts     0x00fc, r17
 eea:   lds     r17, 0x00f5
 eee:   ori     r17, 0x02       ; 2
 ef0:   sts     0x00f5, r17
 ef4:   cbi     PORTD, 5        ; 0x20 = 32
 ef6:   clr     r16
 ef8:   sts     0x00a1, r16
 efc:   sts     0x00a2, r16
 f00:   ldi     r16, 0x06       ; 6
 f02:   out     SPDR, r16
 f04:   rjmp    Label205

; Referenced from offset 0xeca by rjmp
Label198:
 f06:   sbrs    r18, 0          ; 0x01 = 1
 f08:   rjmp    Label201
 f0a:   ori     r16, 0x81       ; 129
 f0c:   sts     0x00f3, r16
 f10:   andi    r18, 0xfe       ; 254
 f12:   sts     0x00f4, r18
 f16:   lds     r17, 0x00f5
 f1a:   ori     r17, 0x01       ; 1
 f1c:   sts     0x00f5, r17
 f20:   cbi     PORTD, 5        ; 0x20 = 32
 f22:   clr     r29
 f24:   ldi     r28, 0x90       ; 144
 f26:   sts     0x00a1, r28
 f2a:   lds     r17, 0x00fb
 f2e:   cpi     r17, 0x00       ; 0
 f30:   breq    Label200
 f32:   lds     r17, 0x00f9
 f36:   st      Y+, r17
 f38:   sts     0x00a2, r28
 f3c:   lds     r16, 0x00fb
 f40:   sts     0x00f7, r16
 f44:   ldi     r16, 0x03       ; 3
 f46:   lds     r17, 0x00fa
 f4a:   cpi     r17, 0x01       ; 1
 f4c:   brne    Label199
 f4e:   ori     r16, 0x08       ; 8

; Referenced from offset 0xf4c by brne
Label199:
 f50:   out     SPDR, r16
 f52:   rjmp    Label205

; Referenced from offset 0xf30 by breq
Label200:
 f54:   sts     0x00a2, r28
 f58:   ldi     r16, 0x01       ; 1
 f5a:   sts     0x00f7, r16
 f5e:   ldi     r16, 0x05       ; 5
 f60:   out     SPDR, r16
 f62:   rjmp    Label205

; Referenced from offset 0xf08 by rjmp
Label201:
 f64:   sbrs    r18, 2          ; 0x04 = 4
 f66:   rjmp    Label203
 f68:   ori     r16, 0x81       ; 129
 f6a:   sts     0x00f3, r16
 f6e:   andi    r18, 0xfb       ; 251
 f70:   sts     0x00f4, r18
 f74:   ldi     r17, 0x02       ; 2
 f76:   sts     0x00fc, r17
 f7a:   lds     r17, 0x00f5
 f7e:   ori     r17, 0x04       ; 4
 f80:   sts     0x00f5, r17
 f84:   cbi     PORTD, 5        ; 0x20 = 32
 f86:   nop
 f88:   nop
 f8a:   nop
 f8c:   sbi     PORTD, 5        ; 0x20 = 32
 f8e:   ldi     r16, 0x30       ; 48

; Referenced from offset 0xf92 by brne
Label202:
 f90:   dec     r16
 f92:   brne    Label202
 f94:   clr     r29
 f96:   ldi     r28, 0x90       ; 144
 f98:   sts     0x00a1, r28
 f9c:   ldi     r16, 0x10       ; 16
 f9e:   st      Y+, r16
 fa0:   st      Y+, r16
 fa2:   sts     0x00a2, r28
 fa6:   ldi     r16, 0x06       ; 6
 fa8:   sts     0x00f7, r16
 fac:   ldi     r16, 0xa1       ; 161
 fae:   out     SPDR, r16
 fb0:   rjmp    Label205

; Referenced from offset 0xf66 by rjmp
Label203:
 fb2:   sbrs    r18, 3          ; 0x08 = 8
 fb4:   rjmp    Label205
 fb6:   ori     r16, 0x81       ; 129
 fb8:   sts     0x00f3, r16
 fbc:   andi    r18, 0xf7       ; 247
 fbe:   sts     0x00f4, r18
 fc2:   ldi     r17, 0x03       ; 3
 fc4:   sts     0x00fc, r17
 fc8:   lds     r17, 0x00f5
 fcc:   ori     r17, 0x08       ; 8
 fce:   sts     0x00f5, r17
 fd2:   cbi     PORTD, 5        ; 0x20 = 32
 fd4:   nop
 fd6:   nop
 fd8:   nop
 fda:   sbi     PORTD, 5        ; 0x20 = 32
 fdc:   ldi     r16, 0x30       ; 48

; Referenced from offset 0xfe0 by brne
Label204:
 fde:   dec     r16
 fe0:   brne    Label204
 fe2:   clr     r29
 fe4:   ldi     r28, 0x90       ; 144
 fe6:   sts     0x00a1, r28
 fea:   ldi     r16, 0x20       ; 32
 fec:   st      Y+, r16
 fee:   st      Y+, r16
 ff0:   sts     0x00a2, r28
 ff4:   ldi     r16, 0x07       ; 7
 ff6:   sts     0x00f7, r16
 ffa:   ldi     r16, 0xa1       ; 161
 ffc:   out     SPDR, r16
 ffe:   rjmp    Label205

; Referenced from offset 0xeb4 by rjmp
; Referenced from offset 0xebe by rjmp
; Referenced from offset 0xf04 by rjmp
; Referenced from offset 0xf52 by rjmp
; Referenced from offset 0xf62 by rjmp
; Referenced from offset 0xfb0 by rjmp
; Referenced from offset 0xfb4 by rjmp
; Referenced from offset 0xffe by rjmp
Label205:
1000:   lds     r16, 0x00f3
1004:   sbrs    r16, 2          ; 0x04 = 4
1006:   rjmp    Label230
1008:   lds     r17, 0x00f5
100c:   sbrs    r17, 0          ; 0x01 = 1
100e:   rjmp    Label210
1010:   sbrc    r16, 0          ; 0x01 = 1
1012:   rjmp    Label206
1014:   sbrc    r16, 1          ; 0x02 = 2
1016:   rjmp    Label207

; Referenced from offset 0x1012 by rjmp
Label206:
1018:   andi    r16, 0xfa       ; 250
101a:   ori     r16, 0x02       ; 2
101c:   sts     0x00f3, r16
1020:   ldi     r16, 0xa5       ; 165
1022:   sts     0x00a3, r16
1026:   clr     r16
1028:   sts     0x00f8, r16
102c:   out     SPDR, r16
102e:   rjmp    Label230

; Referenced from offset 0x1016 by rjmp
Label207:
1030:   sbi     PORTD, 5        ; 0x20 = 32
1032:   andi    r16, 0x79       ; 121
1034:   sts     0x00f3, r16
1038:   andi    r17, 0xfe       ; 254
103a:   sts     0x00f5, r17
103e:   ldi     r27, 0x01       ; 1
1040:   ldi     r26, 0x00       ; 0
1042:   clr     r29
1044:   ldi     r28, 0xa5       ; 165
1046:   lds     r18, 0x00a4
104a:   clr     r17

; Referenced from offset 0x1054 by brne
Label208:
104c:   ld      r16, Y+
104e:   st      X+, r16
1050:   inc     r17
1052:   cp      r18, r28
1054:   brne    Label208
1056:   sts     0x00f8, r17
105a:   ori     r22, 0x02       ; 2
105c:   lds     r16, 0x00ff
1060:   andi    r16, 0x03       ; 3
1062:   breq    Label209
1064:   rjmp    Label230

; Referenced from offset 0x1062 by breq
Label209:
1066:   ori     r16, 0x01       ; 1
1068:   sts     0x00ff, r16
106c:   rjmp    Label230

; Referenced from offset 0x100e by rjmp
Label210:
106e:   sbrs    r17, 1          ; 0x02 = 2
1070:   rjmp    Label216
1072:   sbi     PORTD, 5        ; 0x20 = 32
1074:   lds     r18, 0x00f6
1078:   sbrc    r18, 0          ; 0x01 = 1
107a:   rjmp    Label211
107c:   sbrc    r18, 1          ; 0x02 = 2
107e:   rjmp    Label215

; Referenced from offset 0x107a by rjmp
Label211:
1080:   andi    r16, 0xfb       ; 251
1082:   sts     0x00f3, r16
1086:   andi    r18, 0xfe       ; 254
1088:   ori     r18, 0x02       ; 2
108a:   sts     0x00f6, r18
108e:   clr     r29
1090:   ldi     r28, 0x90       ; 144
1092:   sts     0x00a1, r28
1096:   ldi     r27, 0x01       ; 1
1098:   ldi     r26, 0x13       ; 19
109a:   ld      r18, X+
109c:   cpi     r18, 0x00       ; 0
109e:   breq    Label214
10a0:   ld      r17, X+
10a2:   st      Y+, r17
10a4:   ld      r16, X+

; Referenced from offset 0x10ac by brne
Label212:
10a6:   ld      r17, X+
10a8:   st      Y+, r17
10aa:   dec     r18
10ac:   brne    Label212
10ae:   sts     0x00a2, r28
10b2:   cbi     PORTD, 5        ; 0x20 = 32
10b4:   mov     r17, r16
10b6:   ldi     r16, 0x02       ; 2
10b8:   cpi     r17, 0x01       ; 1
10ba:   brne    Label213
10bc:   ori     r16, 0x08       ; 8

; Referenced from offset 0x10ba by brne
Label213:
10be:   out     SPDR, r16
10c0:   rjmp    Label230

; Referenced from offset 0x109e by breq
Label214:
10c2:   ld      r17, X+
10c4:   st      Y+, r17
10c6:   sts     0x00a2, r28
10ca:   cbi     PORTD, 5        ; 0x20 = 32
10cc:   ldi     r16, 0x01       ; 1
10ce:   out     SPDR, r16
10d0:   rjmp    Label230

; Referenced from offset 0x107e by rjmp
Label215:
10d2:   sbrs    r18, 7          ; 0x80 = 128
10d4:   rjmp    Label230
10d6:   andi    r17, 0xfd       ; 253
10d8:   sts     0x00f5, r17
10dc:   andi    r18, 0x7d       ; 125
10de:   sts     0x00f6, r18
10e2:   andi    r16, 0x7a       ; 122
10e4:   sts     0x00f3, r16
10e8:   lds     r16, 0x0067
10ec:   ori     r16, 0x08       ; 8
10ee:   sts     0x0067, r16
10f2:   ori     r23, 0x80       ; 128
10f4:   rjmp    Label230

; Referenced from offset 0x1070 by rjmp
Label216:
10f6:   sbrs    r17, 2          ; 0x04 = 4
10f8:   rjmp    Label222
10fa:   sbrc    r16, 0          ; 0x01 = 1
10fc:   rjmp    Label217
10fe:   sbrc    r16, 1          ; 0x02 = 2
1100:   rjmp    Label218

; Referenced from offset 0x10fc by rjmp
Label217:
1102:   lds     r18, 0x00f6
1106:   sbrs    r18, 7          ; 0x80 = 128
1108:   rjmp    Label230
110a:   andi    r16, 0xfa       ; 250
110c:   ori     r16, 0x02       ; 2
110e:   sts     0x00f3, r16
1112:   ldi     r16, 0xa5       ; 165
1114:   sts     0x00a3, r16
1118:   clr     r16
111a:   sts     0x00f8, r16
111e:   out     SPDR, r16
1120:   rjmp    Label230

; Referenced from offset 0x1100 by rjmp
Label218:
1122:   sbrs    r16, 3          ; 0x08 = 8
1124:   rjmp    Label220
1126:   andi    r16, 0xf3       ; 243
1128:   sts     0x00f3, r16
112c:   ldi     r16, 0x28       ; 40

; Referenced from offset 0x1130 by brne
Label219:
112e:   dec     r16
1130:   brne    Label219
1132:   out     SPDR, r16
1134:   rjmp    Label230

; Referenced from offset 0x1124 by rjmp
Label220:
1136:   andi    r16, 0x79       ; 121
1138:   sts     0x00f3, r16
113c:   andi    r17, 0xfb       ; 251
113e:   sts     0x00f5, r17
1142:   lds     r18, 0x00f6
1146:   andi    r18, 0x7f       ; 127
1148:   sts     0x00f6, r18
114c:   lds     r16, 0x00ff
1150:   ori     r16, 0x80       ; 128
1152:   sts     0x00ff, r16
1156:   clr     r29
1158:   ldi     r28, 0xa5       ; 165
115a:   ld      r16, Y+
115c:   cpi     r16, 0xa1       ; 161
115e:   brne    Label221
1160:   ld      r16, Y+
1162:   cpi     r16, 0x13       ; 19
1164:   brne    Label221
1166:   mov     r17, r16
1168:   ld      r16, Y+
116a:   add     r17, r16
116c:   ld      r16, Y+
116e:   add     r17, r16
1170:   ld      r16, Y+
1172:   add     r17, r16
1174:   ld      r16, Y+
1176:   cp      r17, r16
1178:   brne    Label221
117a:   ldi     r28, 0xa5       ; 165
117c:   inc     r28
117e:   inc     r28
1180:   ld      r16, Y+
1182:   sts     0x00bc, r16
1186:   ld      r16, Y+
1188:   sts     0x00bd, r16
118c:   ld      r16, Y+
118e:   sts     0x00be, r16
1192:   rjmp    Label230

; Referenced from offset 0x115e by brne
; Referenced from offset 0x1164 by brne
; Referenced from offset 0x1178 by brne
Label221:
1194:   clr     r16
1196:   sts     0x00bc, r16
119a:   sts     0x00bd, r16
119e:   sts     0x00be, r16
11a2:   rjmp    Label230

; Referenced from offset 0x10f8 by rjmp
Label222:
11a4:   sbrs    r17, 3          ; 0x08 = 8
11a6:   rjmp    Label230
11a8:   sbrc    r16, 0          ; 0x01 = 1
11aa:   rjmp    Label223
11ac:   sbrc    r16, 1          ; 0x02 = 2
11ae:   rjmp    Label224

; Referenced from offset 0x11aa by rjmp
Label223:
11b0:   lds     r18, 0x00f6
11b4:   sbrs    r18, 7          ; 0x80 = 128
11b6:   rjmp    Label230
11b8:   andi    r16, 0xfa       ; 250
11ba:   ori     r16, 0x02       ; 2
11bc:   sts     0x00f3, r16
11c0:   ldi     r16, 0xa5       ; 165
11c2:   sts     0x00a3, r16
11c6:   clr     r16
11c8:   sts     0x00f8, r16
11cc:   out     SPDR, r16
11ce:   rjmp    Label230

; Referenced from offset 0x11ae by rjmp
Label224:
11d0:   sbrs    r16, 3          ; 0x08 = 8
11d2:   rjmp    Label226
11d4:   andi    r16, 0xf3       ; 243
11d6:   sts     0x00f3, r16
11da:   ldi     r16, 0x28       ; 40

; Referenced from offset 0x11de by brne
Label225:
11dc:   dec     r16
11de:   brne    Label225
11e0:   out     SPDR, r16
11e2:   rjmp    Label230

; Referenced from offset 0x11d2 by rjmp
Label226:
11e4:   andi    r16, 0x79       ; 121
11e6:   sts     0x00f3, r16
11ea:   andi    r17, 0xf7       ; 247
11ec:   sts     0x00f5, r17
11f0:   lds     r18, 0x00f6
11f4:   andi    r18, 0x7f       ; 127
11f6:   sts     0x00f6, r18
11fa:   clr     r29
11fc:   ldi     r28, 0xa5       ; 165
11fe:   ld      r16, Y+
1200:   cpi     r16, 0xa1       ; 161
1202:   brne    Label227
1204:   ld      r16, Y+
1206:   cpi     r16, 0x24       ; 36
1208:   brne    Label227
120a:   mov     r17, r16
120c:   ld      r16, Y+
120e:   add     r17, r16
1210:   ld      r16, Y+
1212:   add     r17, r16
1214:   ld      r16, Y+
1216:   add     r17, r16
1218:   ld      r16, Y+
121a:   add     r17, r16
121c:   ld      r16, Y+
121e:   cp      r17, r16
1220:   brne    Label227
1222:   ldi     r28, 0xa5       ; 165
1224:   inc     r28
1226:   inc     r28
1228:   ld      r16, Y+
122a:   sts     0x00b6, r16
122e:   ld      r16, Y+
1230:   sts     0x00b7, r16
1234:   ld      r16, Y+
1236:   sts     0x00b8, r16
123a:   ld      r8, Y+
123c:   lds     r16, 0x00ff
1240:   sbrc    r16, 1          ; 0x02 = 2
1242:   rjmp    Label230
1244:   andi    r16, 0xfe       ; 254
1246:   ori     r16, 0x02       ; 2
1248:   sts     0x00ff, r16
124c:   rjmp    Label230

; Referenced from offset 0x1202 by brne
; Referenced from offset 0x1208 by brne
; Referenced from offset 0x1220 by brne
Label227:
124e:   lds     r16, 0x00ff
1252:   sbrc    r16, 0          ; 0x01 = 1
1254:   rjmp    Label228
1256:   ori     r16, 0x01       ; 1
1258:   andi    r16, 0xfd       ; 253
125a:   sts     0x00ff, r16
125e:   ldi     r16, 0x05       ; 5
1260:   sts     0x00b9, r16
1264:   rjmp    Label230

; Referenced from offset 0x1254 by rjmp
Label228:
1266:   lds     r17, 0x00b9
126a:   dec     r17
126c:   breq    Label229
126e:   sts     0x00b9, r17
1272:   rjmp    Label230

; Referenced from offset 0x126c by breq
Label229:
1274:   andi    r16, 0xfc       ; 252
1276:   sts     0x00ff, r16
127a:   clr     r16
127c:   clr     r8
127e:   sts     0x00b6, r16
1282:   sts     0x00b7, r16
1286:   sts     0x00b8, r16
128a:   rjmp    Label230

; Referenced from offset 0x1006 by rjmp
; Referenced from offset 0x102e by rjmp
; Referenced from offset 0x1064 by rjmp
; Referenced from offset 0x106c by rjmp
; Referenced from offset 0x10c0 by rjmp
; Referenced from offset 0x10d0 by rjmp
; Referenced from offset 0x10d4 by rjmp
; Referenced from offset 0x10f4 by rjmp
; Referenced from offset 0x1108 by rjmp
; Referenced from offset 0x1120 by rjmp
; Referenced from offset 0x1134 by rjmp
; Referenced from offset 0x1192 by rjmp
; Referenced from offset 0x11a2 by rjmp
; Referenced from offset 0x11a6 by rjmp
; Referenced from offset 0x11b6 by rjmp
; Referenced from offset 0x11ce by rjmp
; Referenced from offset 0x11e2 by rjmp
; Referenced from offset 0x1242 by rjmp
; Referenced from offset 0x124c by rjmp
; Referenced from offset 0x1264 by rjmp
; Referenced from offset 0x1272 by rjmp
; Referenced from offset 0x128a by rjmp
Label230:
128c:   lds     r16, 0x0065
1290:   sbrs    r16, 6          ; 0x40 = 64
1292:   rjmp    Label240
1294:   ldi     r28, 0xde       ; 222
1296:   clr     r29
1298:   ld      r16, Y+
129a:   sts     0x00ef, r28
129e:   andi    r16, 0xf0       ; 240
12a0:   cpi     r16, 0x00       ; 0
12a2:   brne    Label231
12a4:   rcall   Function9
12a6:   rjmp    Label240

; Referenced from offset 0x12a2 by brne
Label231:
12a8:   cpi     r16, 0x40       ; 64
12aa:   brne    Label232
12ac:   rcall   Function7
12ae:   rjmp    Label240

; Referenced from offset 0x12aa by brne
Label232:
12b0:   cpi     r16, 0x50       ; 80
12b2:   brne    Label233
12b4:   rcall   Function8
12b6:   rjmp    Label240

; Referenced from offset 0x12b2 by brne
Label233:
12b8:   cpi     r16, 0x80       ; 128
12ba:   brne    Label234
12bc:   rcall   Function10
12be:   rjmp    Label240

; Referenced from offset 0x12ba by brne
Label234:
12c0:   cpi     r16, 0x90       ; 144
12c2:   brne    Label235
12c4:   rcall   Function11
12c6:   rjmp    Label240

; Referenced from offset 0x12c2 by brne
Label235:
12c8:   cpi     r16, 0xd0       ; 208
12ca:   brne    Label236
12cc:   rcall   Function12
12ce:   rjmp    Label240

; Referenced from offset 0x12ca by brne
Label236:
12d0:   cpi     r16, 0xb0       ; 176
12d2:   brne    Label237
12d4:   rcall   Function14
12d6:   rjmp    Label240

; Referenced from offset 0x12d2 by brne
Label237:
12d8:   cpi     r16, 0xc0       ; 192
12da:   brne    Label238
12dc:   rcall   Function15
12de:   rjmp    Label240

; Referenced from offset 0x12da by brne
Label238:
12e0:   cpi     r16, 0x60       ; 96
12e2:   brne    Label239
12e4:   rcall   Function16
12e6:   rjmp    Label240

; Referenced from offset 0x12e2 by brne
Label239:
12e8:   lds     r16, 0x0065
12ec:   andi    r16, 0xbf       ; 191
12ee:   sts     0x0065, r16
12f2:   rjmp    Label240

; Referenced from offset 0x1292 by rjmp
; Referenced from offset 0x12a6 by rjmp
; Referenced from offset 0x12ae by rjmp
; Referenced from offset 0x12b6 by rjmp
; Referenced from offset 0x12be by rjmp
; Referenced from offset 0x12c6 by rjmp
; Referenced from offset 0x12ce by rjmp
; Referenced from offset 0x12d6 by rjmp
; Referenced from offset 0x12de by rjmp
; Referenced from offset 0x12e6 by rjmp
; Referenced from offset 0x12f2 by rjmp
Label240:
12f4:   sbis    PINB, 3         ; 0x08 = 8
12f6:   rjmp    Label242
12f8:   lds     r16, 0x008e
12fc:   sbrs    r16, 0          ; 0x01 = 1
12fe:   rjmp    Label241
1300:   cbi     PORTC, 7        ; 0x80 = 128
1302:   clr     r16
1304:   sts     0x008e, r16
1308:   out     TCCR1B, r16
130a:   rjmp    Label242

; Referenced from offset 0x12fe by rjmp
Label241:
130c:   sbrs    r16, 1          ; 0x02 = 2
130e:   rjmp    Label242
1310:   clr     r16
1312:   sts     0x008e, r16
1316:   rjmp    Label242

; Referenced from offset 0x12f6 by rjmp
; Referenced from offset 0x130a by rjmp
; Referenced from offset 0x130e by rjmp
; Referenced from offset 0x1316 by rjmp
Label242:
1318:   sbic    PINB, 3         ; 0x08 = 8
131a:   cbi     PORTD, 7        ; 0x80 = 128
131c:   cli
131e:   sbis    PINB, 0         ; 0x01 = 1
1320:   rjmp    Label243
1322:   lds     r16, 0x0068
1326:   andi    r16, 0x12       ; 18
1328:   brne    Label243
132a:   cpi     r23, 0x00       ; 0
132c:   brne    Label243
132e:   cpi     r24, 0x00       ; 0
1330:   brne    Label243
1332:   cpi     r25, 0x00       ; 0
1334:   brne    Label243
1336:   lds     r16, 0x0064
133a:   cpi     r16, 0x00       ; 0
133c:   brne    Label243
133e:   mov     r16, r22
1340:   andi    r16, 0x86       ; 134
1342:   brne    Label243
1344:   lds     r16, 0x0065
1348:   cpi     r16, 0x00       ; 0
134a:   brne    Label243
134c:   lds     r16, 0x006d
1350:   andi    r16, 0x01       ; 1
1352:   brne    Label243
1354:   lds     r16, 0x00f4
1358:   andi    r16, 0x0f       ; 15
135a:   brne    Label243
135c:   lds     r16, 0x00f3
1360:   andi    r16, 0x80       ; 128
1362:   brne    Label243
1364:   lds     r16, 0x008c
1368:   andi    r16, 0x0f       ; 15
136a:   brne    Label243
136c:   sbic    PINB, 3         ; 0x08 = 8
136e:   rjmp    Label244
1370:   cbi     ADCSR, 7        ; 0x80 = 128
1372:   cbi     SPCR, 6         ; 0x40 = 64
1374:   ldi     r16, 0x40       ; 64
1376:   out     MCUCR, r16
1378:   sei
137a:   sleep
137c:   rjmp    Label115

; Referenced from offset 0x1320 by rjmp
; Referenced from offset 0x1328 by brne
; Referenced from offset 0x132c by brne
; Referenced from offset 0x1330 by brne
; Referenced from offset 0x1334 by brne
; Referenced from offset 0x133c by brne
; Referenced from offset 0x1342 by brne
; Referenced from offset 0x134a by brne
; Referenced from offset 0x1352 by brne
; Referenced from offset 0x135a by brne
; Referenced from offset 0x1362 by brne
; Referenced from offset 0x136a by brne
; Referenced from offset 0x1388 by brne
Label243:
137e:   sei
1380:   rjmp    Label115

; Referenced from offset 0x136e by rjmp
Label244:
1382:   lds     r16, 0x008e
1386:   andi    r16, 0x03       ; 3
1388:   brne    Label243
138a:   cbi     ADCSR, 7        ; 0x80 = 128
138c:   cbi     SPCR, 6         ; 0x40 = 64
138e:   cbi     PORTC, 3        ; 0x08 = 8
1390:   cbi     UCR, 4          ; 0x10 = 16
1392:   cbi     UCR, 3          ; 0x08 = 8
1394:   cbi     PORTD, 0        ; 0x01 = 1
1396:   cbi     PORTD, 1        ; 0x02 = 2
1398:   cbi     DDRD, 0         ; 0x01 = 1
139a:   cbi     DDRD, 1         ; 0x02 = 2
139c:   cbi     PORTB, 5        ; 0x20 = 32
139e:   cbi     PORTB, 7        ; 0x80 = 128
13a0:   cbi     PORTD, 7        ; 0x80 = 128
13a2:   cbi     PORTC, 4        ; 0x10 = 16
13a4:   ldi     r16, 0x60       ; 96
13a6:   out     MCUCR, r16
13a8:   sei
13aa:   sleep
13ac:   sbi     DDRD, 1         ; 0x02 = 2
13ae:   sbi     UCR, 4          ; 0x10 = 16
13b0:   sbi     UCR, 3          ; 0x08 = 8
13b2:   sbi     PORTC, 3        ; 0x08 = 8
13b4:   sbi     SPCR, 6         ; 0x40 = 64
13b6:   clr     r16
13b8:   clr     r8
13ba:   sts     0x00b6, r16
13be:   sts     0x00b7, r16
13c2:   sts     0x00b8, r16
13c6:   ldi     r16, 0x01       ; 1
13c8:   sts     0x00ff, r16
13cc:   rjmp    Label115

; Referenced from offset 0xaf4 by rcall
; Referenced from offset 0xb10 by rcall
Function1:
13ce:   ldi     r16, 0xa9       ; 169

; Referenced from offset 0x13d2 by brne
Label245:
13d0:   dec     r16
13d2:   brne    Label245
13d4:   ret


; Referenced from offset 0x90e by rcall
; Referenced from offset 0x912 by rcall
; Referenced from offset 0x916 by rcall
Function2:
13d6:   swap    r16
13d8:   ldi     r17, 0x0f       ; 15
13da:   and     r17, r16
13dc:   cpi     r17, 0x0a       ; 10
13de:   brcc    Label246
13e0:   ldi     r18, 0x30       ; 48
13e2:   rjmp    Label247

; Referenced from offset 0x13de by brcc
Label246:
13e4:   ldi     r18, 0x37       ; 55

; Referenced from offset 0x13e2 by rjmp
Label247:
13e6:   add     r17, r18
13e8:   st      Y+, r17
13ea:   swap    r16
13ec:   andi    r16, 0x0f       ; 15
13ee:   cpi     r16, 0x0a       ; 10
13f0:   brcc    Label248
13f2:   ldi     r18, 0x30       ; 48
13f4:   rjmp    Label249

; Referenced from offset 0x13f0 by brcc
Label248:
13f6:   ldi     r18, 0x37       ; 55

; Referenced from offset 0x13f4 by rjmp
Label249:
13f8:   add     r16, r18
13fa:   st      Y+, r16
13fc:   ret


; Referenced from offset 0x890 by rcall
Function3:
13fe:   ldi     r16, 0x02       ; 2
1400:   st      Y+, r16
1402:   lds     r17, 0x0064
1406:   sbrs    r17, 0          ; 0x01 = 1
1408:   rjmp    Label250
140a:   ldi     r16, 0x34       ; 52
140c:   mov     r17, r16
140e:   st      Y+, r16
1410:   lds     r16, 0x0060
1414:   add     r17, r16
1416:   st      Y+, r16
1418:   lds     r16, 0x0061
141c:   add     r17, r16
141e:   st      Y+, r16
1420:   lds     r16, 0x0062
1424:   add     r17, r16
1426:   st      Y+, r16
1428:   lds     r16, 0x0063
142c:   add     r17, r16
142e:   st      Y+, r16
1430:   st      Y+, r17
1432:   ret


; Referenced from offset 0x1408 by rjmp
Label250:
1434:   ldi     r16, 0x30       ; 48
1436:   st      Y+, r16
1438:   st      Y+, r16
143a:   ret


; Referenced from offset 0x8ae by rcall
Function4:
143c:   ldi     r16, 0x02       ; 2
143e:   st      Y+, r16
1440:   ldi     r16, 0x21       ; 33
1442:   mov     r17, r16
1444:   st      Y+, r16
1446:   lds     r16, 0x0068
144a:   andi    r16, 0xb7       ; 183
144c:   lds     r18, 0x006b
1450:   add     r17, r18
1452:   st      Y+, r18
1454:   st      Y+, r17
1456:   sts     0x0068, r16
145a:   ret


; Referenced from offset 0x145e by rjmp
; Referenced from offset 0x14d8 by rcall
Function5:
145c:   sbic    EECR, 1         ; 0x02 = 2
145e:   rjmp    Function5
1460:   clr     r29
1462:   ldi     r28, 0xd5       ; 213
1464:   lds     r17, 0x00d4
1468:   lsl     r17
146a:   st      Y+, r17
146c:   lds     r17, 0x00d4
1470:   clr     r16
1472:   out     EEARH, r16
1474:   lds     r16, 0x00d3

; Referenced from offset 0x1490 by rjmp
Label251:
1478:   out     EEAR, r16
147a:   sbi     EECR, 0         ; 0x01 = 1
147c:   in      r18, EEDR
147e:   st      Y+, r18
1480:   inc     r16
1482:   out     EEAR, r16
1484:   sbi     EECR, 0         ; 0x01 = 1
1486:   in      r18, EEDR
1488:   st      Y+, r18
148a:   dec     r17
148c:   breq    Label252
148e:   inc     r16
1490:   rjmp    Label251

; Referenced from offset 0x148c by breq
Label252:
1492:   ret


; Referenced from offset 0x1496 by rjmp
; Referenced from offset 0x150a by rcall
Function6:
1494:   sbic    EECR, 1         ; 0x02 = 2
1496:   rjmp    Function6
1498:   lds     r17, 0x00d4
149c:   clr     r29
149e:   ldi     r28, 0xd5       ; 213
14a0:   clr     r16
14a2:   out     EEARH, r16
14a4:   lds     r16, 0x00d3

; Referenced from offset 0x14c0 by rjmp
Label253:
14a8:   out     EEAR, r16
14aa:   ld      r18, Y+
14ac:   out     EEDR, r18
14ae:   cli
14b0:   sbi     EECR, 2         ; 0x04 = 4
14b2:   sbi     EECR, 1         ; 0x02 = 2
14b4:   sei

; Referenced from offset 0x14b8 by rjmp
Label254:
14b6:   sbic    EECR, 1         ; 0x02 = 2
14b8:   rjmp    Label254
14ba:   dec     r17
14bc:   breq    Label255
14be:   inc     r16
14c0:   rjmp    Label253

; Referenced from offset 0x14bc by breq
Label255:
14c2:   ret


; Referenced from offset 0x12ac by rcall
Function7:
14c4:   lds     r28, 0x00ef
14c8:   clr     r29
14ca:   ld      r16, Y+
14cc:   lsl     r16
14ce:   sts     0x00d3, r16
14d2:   ld      r16, Y+
14d4:   sts     0x00d4, r16
14d8:   rcall   Function5
14da:   ori     r23, 0x08       ; 8
14dc:   lds     r16, 0x0065
14e0:   andi    r16, 0xbf       ; 191
14e2:   sts     0x0065, r16
14e6:   ret


; Referenced from offset 0x12b4 by rcall
Function8:
14e8:   ldi     r26, 0xd5       ; 213
14ea:   clr     r27
14ec:   ldi     r28, 0xde       ; 222
14ee:   clr     r29
14f0:   ld      r16, Y+
14f2:   andi    r16, 0x0f       ; 15
14f4:   dec     r16
14f6:   sts     0x00d4, r16
14fa:   ld      r17, Y+
14fc:   lsl     r17
14fe:   sts     0x00d3, r17

; Referenced from offset 0x1508 by brne
Label256:
1502:   ld      r17, Y+
1504:   st      X+, r17
1506:   dec     r16
1508:   brne    Label256
150a:   rcall   Function6
150c:   lds     r16, 0x0067
1510:   ori     r16, 0x04       ; 4
1512:   sts     0x0067, r16
1516:   ori     r23, 0x80       ; 128
1518:   lds     r16, 0x0065
151c:   andi    r16, 0xbf       ; 191
151e:   sts     0x0065, r16
1522:   ret


; Referenced from offset 0x12a4 by rcall
Function9:
1524:   lds     r16, 0x00f4
1528:   ori     r16, 0x04       ; 4
152a:   sts     0x00f4, r16
152e:   lds     r16, 0x00ff
1532:   andi    r16, 0x7f       ; 127
1534:   sts     0x00ff, r16
1538:   ori     r23, 0x10       ; 16
153a:   lds     r16, 0x0065
153e:   andi    r16, 0xbf       ; 191
1540:   sts     0x0065, r16
1544:   andi    r22, 0xfe       ; 254
1546:   andi    r22, 0xf7       ; 247
1548:   ret


; Referenced from offset 0x12bc by rcall
Function10:
154a:   lds     r28, 0x00ef
154e:   clr     r29
1550:   ld      r16, Y+
1552:   sbrc    r16, 0          ; 0x01 = 1
1554:   rjmp    Label257
1556:   clr     r16
1558:   sts     0x006d, r16
155c:   sbi     PORTB, 4        ; 0x10 = 16
155e:   lds     r16, 0x0067
1562:   ori     r16, 0x02       ; 2
1564:   sts     0x0067, r16
1568:   ori     r23, 0x80       ; 128
156a:   lds     r16, 0x0065
156e:   andi    r16, 0xbf       ; 191
1570:   sts     0x0065, r16
1574:   ret


; Referenced from offset 0x1554 by rjmp
Label257:
1576:   ld      r16, Y+
1578:   cpi     r16, 0x00       ; 0
157a:   brne    Label258
157c:   lds     r17, 0x006d
1580:   ori     r17, 0x04       ; 4
1582:   sts     0x006d, r17

; Referenced from offset 0x157a by brne
Label258:
1586:   sts     0x006e, r16
158a:   ld      r16, Y+
158c:   sts     0x006f, r16
1590:   sts     0x0074, r16
1594:   ld      r16, Y+
1596:   sts     0x0070, r16
159a:   ldi     r16, 0x64       ; 100
159c:   sts     0x0071, r16
15a0:   ldi     r16, 0x32       ; 50
15a2:   sts     0x0072, r16
15a6:   ldi     r16, 0x0c       ; 12
15a8:   sts     0x0073, r16
15ac:   lds     r16, 0x006d
15b0:   ori     r16, 0x01       ; 1
15b2:   sts     0x006d, r16
15b6:   sbi     PORTC, 6        ; 0x40 = 64
15b8:   cbi     PORTB, 4        ; 0x10 = 16
15ba:   lds     r16, 0x0067
15be:   ori     r16, 0x02       ; 2
15c0:   sts     0x0067, r16
15c4:   ori     r23, 0x80       ; 128
15c6:   lds     r16, 0x0065
15ca:   andi    r16, 0xbf       ; 191
15cc:   sts     0x0065, r16
15d0:   ret


; Referenced from offset 0x12c4 by rcall
Function11:
15d2:   ori     r23, 0x40       ; 64
15d4:   lds     r16, 0x0065
15d8:   andi    r16, 0xbf       ; 191
15da:   sts     0x0065, r16
15de:   ret


; Referenced from offset 0x12cc by rcall
Function12:
15e0:   lds     r28, 0x00ef
15e4:   clr     r29
15e6:   ld      r16, Y+
15e8:   cpi     r16, 0x03       ; 3
15ea:   brne    Label259
15ec:   ori     r23, 0x20       ; 32
15ee:   rjmp    Label264

; Referenced from offset 0x15ea by brne
Label259:
15f0:   lds     r17, 0x008e
15f4:   cpi     r16, 0x01       ; 1
15f6:   brne    Label260
15f8:   sbrc    r17, 1          ; 0x02 = 2
15fa:   rjmp    Label261
15fc:   ldi     r16, 0xfa       ; 250
15fe:   sts     0x00f2, r16
1602:   clr     r16
1604:   sts     0x008f, r16
1608:   andi    r17, 0xfb       ; 251
160a:   ori     r17, 0x02       ; 2
160c:   rjmp    Label261

; Referenced from offset 0x15f6 by brne
Label260:
160e:   andi    r17, 0xfd       ; 253

; Referenced from offset 0x15fa by rjmp
; Referenced from offset 0x160c by rjmp
Label261:
1610:   ld      r16, Y+
1612:   cpi     r16, 0x00       ; 0
1614:   brne    Label262
1616:   andi    r17, 0xfe       ; 254
1618:   sts     0x008e, r17
161c:   cbi     PORTC, 7        ; 0x80 = 128
161e:   clr     r16
1620:   out     TCCR1B, r16
1622:   rjmp    Label263

; Referenced from offset 0x1614 by brne
Label262:
1624:   ld      r18, Y+
1626:   out     OCR1BL, r18
1628:   sts     0x008e, r17
162c:   sbrc    r17, 0          ; 0x01 = 1
162e:   rjmp    Label263
1630:   ldi     r16, 0x21       ; 33
1632:   out     TCCR1A, r16
1634:   ldi     r16, 0x01       ; 1
1636:   out     TCCR1B, r16
1638:   sbi     PORTC, 7        ; 0x80 = 128
163a:   ori     r17, 0x01       ; 1
163c:   sts     0x008e, r17

; Referenced from offset 0x1622 by rjmp
; Referenced from offset 0x162e by rjmp
Label263:
1640:   lds     r16, 0x0067
1644:   ori     r16, 0x01       ; 1
1646:   sts     0x0067, r16
164a:   ori     r23, 0x80       ; 128

; Referenced from offset 0x15ee by rjmp
Label264:
164c:   lds     r16, 0x0065
1650:   andi    r16, 0xbf       ; 191
1652:   sts     0x0065, r16
1656:   ret


; Referenced from offset 0xc60 by rcall
; Referenced from offset 0xe26 by rcall
Function13:
1658:   cli
165a:   lds     r16, 0x007c
165e:   lds     r17, 0x007b
1662:   sei
1664:   ldi     r18, 0xee       ; 238
1666:   sub     r16, r18
1668:   brcc    Label265
166a:   ldi     r18, 0x02       ; 2
166c:   inc     r18
166e:   rjmp    Label266

; Referenced from offset 0x1668 by brcc
Label265:
1670:   ldi     r18, 0x02       ; 2

; Referenced from offset 0x166e by rjmp
Label266:
1672:   sub     r17, r18
1674:   brcc    Label267
1676:   sbi     PORTA, 0        ; 0x01 = 1
1678:   ret


; Referenced from offset 0x1674 by brcc
Label267:
167a:   cbi     PORTA, 0        ; 0x01 = 1
167c:   ret


; Referenced from offset 0x12d4 by rcall
Function14:
167e:   lds     r16, 0x00f4
1682:   sbrc    r16, 0          ; 0x01 = 1
1684:   rjmp    Label270
1686:   lds     r16, 0x00f5
168a:   sbrc    r16, 0          ; 0x01 = 1
168c:   rjmp    Label270
168e:   lds     r28, 0x00ef
1692:   clr     r29
1694:   ld      r16, Y+
1696:   cpi     r16, 0xff       ; 255
1698:   brne    Label268
169a:   ld      r17, Y+
169c:   dec     r28
169e:   cpi     r17, 0xff       ; 255
16a0:   brne    Label268
16a2:   clr     r16
16a4:   rjmp    Label269

; Referenced from offset 0x1698 by brne
; Referenced from offset 0x16a0 by brne
Label268:
16a6:   sts     0x00f9, r16
16aa:   ld      r16, Y+
16ac:   sts     0x00fa, r16
16b0:   ld      r16, Y+

; Referenced from offset 0x16a4 by rjmp
Label269:
16b2:   sts     0x00fb, r16
16b6:   lds     r16, 0x00f4
16ba:   ori     r16, 0x01       ; 1
16bc:   sts     0x00f4, r16
16c0:   lds     r16, 0x0065
16c4:   andi    r16, 0xbf       ; 191
16c6:   sts     0x0065, r16

; Referenced from offset 0x1684 by rjmp
; Referenced from offset 0x168c by rjmp
Label270:
16ca:   ret


; Referenced from offset 0x12dc by rcall
Function15:
16cc:   lds     r16, 0x00f4
16d0:   sbrc    r16, 1          ; 0x02 = 2
16d2:   rjmp    Label273
16d4:   lds     r16, 0x00f5
16d8:   sbrc    r16, 1          ; 0x02 = 2
16da:   rjmp    Label273
16dc:   ldi     r26, 0x13       ; 19
16de:   ldi     r27, 0x01       ; 1
16e0:   ldi     r28, 0xde       ; 222
16e2:   clr     r29
16e4:   ld      r16, Y+
16e6:   andi    r16, 0x0f       ; 15
16e8:   subi    r16, 0x02       ; 2
16ea:   st      X+, r16
16ec:   ld      r17, Y+
16ee:   cpi     r17, 0xff       ; 255
16f0:   brne    Label271
16f2:   ld      r18, Y+
16f4:   dec     r28
16f6:   cpi     r18, 0xff       ; 255
16f8:   brne    Label271
16fa:   dec     r26
16fc:   clr     r16
16fe:   st      X+, r16
1700:   inc     r16
1702:   inc     r28
1704:   rjmp    Label272

; Referenced from offset 0x16f0 by brne
; Referenced from offset 0x16f8 by brne
Label271:
1706:   st      X+, r17
1708:   ld      r17, Y+
170a:   st      X+, r17

; Referenced from offset 0x1704 by rjmp
; Referenced from offset 0x1712 by brne
Label272:
170c:   ld      r17, Y+
170e:   st      X+, r17
1710:   dec     r16
1712:   brne    Label272
1714:   lds     r16, 0x00f4
1718:   ori     r16, 0x02       ; 2
171a:   sts     0x00f4, r16
171e:   lds     r16, 0x0065
1722:   andi    r16, 0xbf       ; 191
1724:   sts     0x0065, r16

; Referenced from offset 0x16d2 by rjmp
; Referenced from offset 0x16da by rjmp
Label273:
1728:   ret


; Referenced from offset 0x12e4 by rcall
Function16:
172a:   lds     r16, 0x0075
172e:   sbrs    r16, 0          ; 0x01 = 1
1730:   rjmp    Label274
1732:   ori     r22, 0x04       ; 4
1734:   rjmp    Label275

; Referenced from offset 0x1730 by rjmp
Label274:
1736:   lds     r16, 0x00bb
173a:   ori     r16, 0x01       ; 1
173c:   sts     0x00bb, r16
1740:   ori     r25, 0x40       ; 64

; Referenced from offset 0x1734 by rjmp
Label275:
1742:   lds     r16, 0x0065
1746:   andi    r16, 0xbf       ; 191
1748:   sts     0x0065, r16
174c:   ret

