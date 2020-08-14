// XMega65 Kernal Development Template
// Each function of the kernal is a no-args function
// The functions are placed in the SYSCALLS table surrounded by JMP and NOP
  .file [name="checkpoint2.2.bin", type="bin", segments="XMega65Bin"]
.segmentdef XMega65Bin [segments="Syscall, Code, Data, Stack, Zeropage"]
.segmentdef Syscall [start=$8000, max=$81ff]
.segmentdef Code [start=$8200, min=$8200, max=$bdff]
.segmentdef Data [startAfter="Code", min=$8200, max=$bdff]
.segmentdef Stack [min=$be00, max=$beff, fill]
.segmentdef Zeropage [min=$bf00, max=$bfff, fill]
  // Some definitions of addresses and special values that this program uses
  .label RASTER = $d012
  .label VIC_MEMORY = $d018
  .label SCREEN = $400
  .label BGCOL = $d021
  .label COLS = $d800
  .const BLACK = 0
  .const WHITE = 1
  .const JMP = $4c
  .const NOP = $ea
.segment Code
main: {
    .label sc = 4
    .label msg = 2
    // Initialize screen memory and select correct font
    lda #$14
    sta VIC_MEMORY
    ldx #' '
    lda #<SCREEN
    sta.z memset.str
    lda #>SCREEN
    sta.z memset.str+1
    lda #<$28*$19
    sta.z memset.num
    lda #>$28*$19
    sta.z memset.num+1
    jsr memset
    ldx #WHITE
    lda #<COLS
    sta.z memset.str
    lda #>COLS
    sta.z memset.str+1
    lda #<$28*$19
    sta.z memset.num
    lda #>$28*$19
    sta.z memset.num+1
    jsr memset
    lda #<SCREEN+$28
    sta.z sc
    lda #>SCREEN+$28
    sta.z sc+1
    lda #<MESSAGE
    sta.z msg
    lda #>MESSAGE
    sta.z msg+1
  // A simple copy routine to copy the string
  __b1:
    ldy #0
    lda (msg),y
    cmp #0
    bne __b2
  __b3:
    lda #$36
    cmp RASTER
    beq __b4
    lda #$42
    cmp RASTER
    beq __b4
    lda #BLACK
    sta BGCOL
    jmp __b3
  __b4:
    lda #WHITE
    sta BGCOL
    jmp __b3
  __b2:
    ldy #0
    lda (msg),y
    sta (sc),y
    inc.z sc
    bne !+
    inc.z sc+1
  !:
    inc.z msg
    bne !+
    inc.z msg+1
  !:
    jmp __b1
}
// Copies the character c (an unsigned char) to the first num characters of the object pointed to by the argument str.
// memset(void* zeropage(4) str, byte register(X) c, word zeropage(2) num)
memset: {
    .label end = 2
    .label dst = 4
    .label num = 2
    .label str = 4
    lda.z num
    bne !+
    lda.z num+1
    beq __breturn
  !:
    lda.z end
    clc
    adc.z str
    sta.z end
    lda.z end+1
    adc.z str+1
    sta.z end+1
  __b2:
    lda.z dst+1
    cmp.z end+1
    bne __b3
    lda.z dst
    cmp.z end
    bne __b3
  __breturn:
    rts
  __b3:
    txa
    ldy #0
    sta (dst),y
    inc.z dst
    bne !+
    inc.z dst+1
  !:
    jmp __b2
}
cpukil: {
    rts
}
reserved: {
    rts
}
vf011wr: {
    rts
}
vf011rd: {
    rts
}
alttabkey: {
    rts
}
restorkey: {
    rts
}
pagfault: {
    rts
}
reset: {
    rts
}
syscall3f: {
    rts
}
syscall3e: {
    rts
}
syscall3d: {
    rts
}
syscall3c: {
    rts
}
syscall3b: {
    rts
}
syscall3a: {
    rts
}
syscall39: {
    rts
}
syscall38: {
    rts
}
syscall37: {
    rts
}
syscall36: {
    rts
}
syscall35: {
    rts
}
syscall34: {
    rts
}
syscall33: {
    rts
}
syscall32: {
    rts
}
syscall31: {
    rts
}
syscall30: {
    rts
}
syscall2c: {
    rts
}
syscall2b: {
    rts
}
syscall2a: {
    rts
}
syscall29: {
    rts
}
syscall28: {
    rts
}
syscall27: {
    rts
}
syscall26: {
    rts
}
syscall25: {
    rts
}
syscall24: {
    rts
}
syscall23: {
    rts
}
syscall22: {
    rts
}
syscall21: {
    rts
}
syscall20: {
    rts
}
syscall1f: {
    rts
}
syscall1e: {
    rts
}
syscall1d: {
    rts
}
syscall1c: {
    rts
}
syscall1b: {
    rts
}
syscall1a: {
    rts
}
syscall19: {
    rts
}
syscall18: {
    rts
}
syscall17: {
    rts
}
syscall16: {
    rts
}
syscall15: {
    rts
}
syscall14: {
    rts
}
syscall13: {
    rts
}
syscall10: {
    rts
}
syscallf: {
    rts
}
syscalle: {
    rts
}
syscalld: {
    rts
}
syscallc: {
    rts
}
syscallb: {
    rts
}
syscalla: {
    rts
}
syscall09: {
    rts
}
syscall08: {
    rts
}
syscall07: {
    rts
}
syscall06: {
    rts
}
syscall05: {
    rts
}
syscall04: {
    rts
}
syscall03: {
    rts
}
syscall00: {
    rts
}
syscall02: {
    lda #'<'
    sta SCREEN+$4e
    rts
}
// Here are a couple sample SYSCALL handlers that just display a character on the screen 
syscall01: {
    lda #'>'
    sta SCREEN+$4f
    rts
}
.segment Data
  // Some text to display
  MESSAGE: .text "Checkpoint 2.2 by ocba0001"
  .byte 0
.segment Syscall
  SYSCALLS: .byte JMP
  .word syscall00
  .byte NOP, JMP
  .word syscall01
  .byte NOP, JMP
  .word syscall02
  .byte NOP, JMP
  .word syscall03
  .byte NOP, JMP
  .word syscall04
  .byte NOP, JMP
  .word syscall05
  .byte NOP, JMP
  .word syscall06
  .byte NOP, JMP
  .word syscall07
  .byte NOP, JMP
  .word syscall08
  .byte NOP, JMP
  .word syscall09
  .byte NOP, JMP
  .word syscalla
  .byte NOP, JMP
  .word syscallb
  .byte NOP, JMP
  .word syscallc
  .byte NOP, JMP
  .word syscalld
  .byte NOP, JMP
  .word syscalle
  .byte NOP, JMP
  .word syscallf
  .byte NOP, JMP
  .word syscall10
  .byte NOP, JMP
  .word syscall13
  .byte NOP, JMP
  .word syscall14
  .byte NOP, JMP
  .word syscall15
  .byte NOP, JMP
  .word syscall16
  .byte NOP, JMP
  .word syscall17
  .byte NOP, JMP
  .word syscall18
  .byte NOP, JMP
  .word syscall19
  .byte NOP, JMP
  .word syscall1a
  .byte NOP, JMP
  .word syscall1b
  .byte NOP, JMP
  .word syscall1c
  .byte NOP, JMP
  .word syscall1d
  .byte NOP, JMP
  .word syscall1e
  .byte NOP, JMP
  .word syscall1f
  .byte NOP, JMP
  .word syscall20
  .byte NOP, JMP
  .word syscall21
  .byte NOP, JMP
  .word syscall22
  .byte NOP, JMP
  .word syscall23
  .byte NOP, JMP
  .word syscall24
  .byte NOP, JMP
  .word syscall25
  .byte NOP, JMP
  .word syscall26
  .byte NOP, JMP
  .word syscall27
  .byte NOP, JMP
  .word syscall28
  .byte NOP, JMP
  .word syscall29
  .byte NOP, JMP
  .word syscall2a
  .byte NOP, JMP
  .word syscall2b
  .byte NOP, JMP
  .word syscall2c
  .byte NOP, JMP
  .word syscall30
  .byte NOP, JMP
  .word syscall31
  .byte NOP, JMP
  .word syscall32
  .byte NOP, JMP
  .word syscall33
  .byte NOP, JMP
  .word syscall34
  .byte NOP, JMP
  .word syscall35
  .byte NOP, JMP
  .word syscall36
  .byte NOP, JMP
  .word syscall37
  .byte NOP, JMP
  .word syscall38
  .byte NOP, JMP
  .word syscall39
  .byte NOP, JMP
  .word syscall3a
  .byte NOP, JMP
  .word syscall3b
  .byte NOP, JMP
  .word syscall3c
  .byte NOP, JMP
  .word syscall3d
  .byte NOP, JMP
  .word syscall3e
  .byte NOP, JMP
  .word syscall3f
  .byte NOP
  .align $100
  TRAPS: .byte JMP
  .word reset
  .byte NOP, JMP
  .word pagfault
  .byte NOP, JMP
  .word restorkey
  .byte NOP, JMP
  .word alttabkey
  .byte NOP, JMP
  .word vf011rd
  .byte NOP, JMP
  .word vf011wr
  .byte NOP, JMP
  .word reserved
  .byte NOP, JMP
  .word cpukil
  .byte NOP
