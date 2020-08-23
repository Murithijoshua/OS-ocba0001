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
syscall3F: {
    lda #'>'
    sta SCREEN+$11
    rts
}
syscall3E: {
    lda #'<'
    sta SCREEN+$12
    rts
}
syscall3D: {
    lda #'>'
    sta SCREEN+$13
    rts
}
syscall3C: {
    lda #'<'
    sta SCREEN+$14
    rts
}
syscall3B: {
    lda #'>'
    sta SCREEN+$15
    rts
}
syscall3A: {
    lda #'<'
    sta SCREEN+$16
    rts
}
syscall39: {
    lda #'<'
    sta SCREEN+$17
    rts
}
syscall38: {
    lda #'<'
    sta SCREEN+$18
    rts
}
syscall37: {
    lda #'>'
    sta SCREEN+$19
    rts
}
syscall36: {
    lda #'<'
    sta SCREEN+$1a
    rts
}
syscall35: {
    lda #'>'
    sta SCREEN+$1b
    rts
}
syscall34: {
    lda #'<'
    sta SCREEN+$1c
    rts
}
syscall33: {
    lda #'>'
    sta SCREEN+$1d
    rts
}
syscall32: {
    lda #'<'
    sta SCREEN+$1e
    rts
}
syscall31: {
    lda #'>'
    sta SCREEN+$1f
    rts
}
syscall30: {
    lda #'<'
    sta SCREEN+$20
    rts
}
syscall2F: {
    lda #'>'
    sta SCREEN+$21
    rts
}
syscall2E: {
    lda #'<'
    sta SCREEN+$22
    rts
}
syscall2D: {
    lda #'>'
    sta SCREEN+$23
    rts
}
syscall2C: {
    lda #'<'
    sta SCREEN+$24
    rts
}
syscall2B: {
    lda #'>'
    sta SCREEN+$25
    rts
}
syscall2A: {
    lda #'<'
    sta SCREEN+$26
    rts
}
syscall29: {
    lda #'<'
    sta SCREEN+$27
    rts
}
syscall28: {
    lda #'<'
    sta SCREEN+$28
    rts
}
syscall27: {
    lda #'>'
    sta SCREEN+$29
    rts
}
syscall26: {
    lda #'<'
    sta SCREEN+$2a
    rts
}
syscall25: {
    lda #'>'
    sta SCREEN+$2b
    rts
}
syscall24: {
    lda #'<'
    sta SCREEN+$2c
    rts
}
syscall23: {
    lda #'>'
    sta SCREEN+$2d
    rts
}
syscall22: {
    lda #'<'
    sta SCREEN+$2e
    rts
}
syscall21: {
    lda #'>'
    sta SCREEN+$2f
    rts
}
syscall20: {
    lda #'<'
    sta SCREEN+$30
    rts
}
syscall1F: {
    lda #'>'
    sta SCREEN+$31
    rts
}
syscall1E: {
    lda #'<'
    sta SCREEN+$32
    rts
}
syscall1D: {
    lda #'>'
    sta SCREEN+$33
    rts
}
syscall1C: {
    lda #'<'
    sta SCREEN+$34
    rts
}
syscall1B: {
    lda #'>'
    sta SCREEN+$35
    rts
}
syscall1A: {
    lda #'<'
    sta SCREEN+$36
    rts
}
syscall19: {
    lda #'>'
    sta SCREEN+$37
    rts
}
syscall18: {
    lda #'<'
    sta SCREEN+$38
    rts
}
syscall17: {
    lda #'>'
    sta SCREEN+$39
    rts
}
syscall16: {
    lda #'<'
    sta SCREEN+$3a
    rts
}
syscall15: {
    lda #'>'
    sta SCREEN+$3b
    rts
}
syscall14: {
    lda #'<'
    sta SCREEN+$3c
    rts
}
syscall13: {
    lda #'>'
    sta SCREEN+$3d
    rts
}
securexit: {
    lda #'<'
    sta SCREEN+$3e
    rts
}
securentr: {
    lda #'<'
    sta SCREEN+$3f
    rts
}
syscall10: {
    lda #'<'
    sta SCREEN+$40
    rts
}
syscallF: {
    lda #'>'
    sta SCREEN+$41
    rts
}
syscallE: {
    lda #'<'
    sta SCREEN+$42
    rts
}
syscallD: {
    lda #'>'
    sta SCREEN+$43
    rts
}
syscallC: {
    lda #'<'
    sta SCREEN+$44
    rts
}
syscallB: {
    lda #'>'
    sta SCREEN+$45
    rts
}
syscallA: {
    lda #'<'
    sta SCREEN+$46
    rts
}
syscall9: {
    lda #'>'
    sta SCREEN+$47
    rts
}
syscall8: {
    lda #'<'
    sta SCREEN+$48
    rts
}
syscall7: {
    lda #'>'
    sta SCREEN+$49
    rts
}
syscall6: {
    lda #'<'
    sta SCREEN+$4a
    rts
}
syscall5: {
    lda #'>'
    sta SCREEN+$4b
    rts
}
syscall4: {
    lda #'<'
    sta SCREEN+$4c
    rts
}
syscall3: {
    lda #'>'
    sta SCREEN+$4d
    rts
}
syscall2: {
    lda #'<'
    sta SCREEN+$4e
    rts
}
syscall1: {
    lda #'>'
    sta SCREEN+$4f
    rts
}
// Here are a couple sample SYSCALL handlers that just display a character on the screen 
syscall0: {
    lda #'<'
    sta SCREEN+$50
    rts
}
.segment Data
  // Some text to display
  MESSAGE: .text "Checkpoint 2.2 by ocba0001"
  .byte 0
.segment Syscall
  SYSCALLS: .byte JMP
  .word syscall0
  .byte NOP, JMP
  .word syscall1
  .byte NOP, JMP
  .word syscall2
  .byte NOP, JMP
  .word syscall3
  .byte NOP, JMP
  .word syscall4
  .byte NOP, JMP
  .word syscall5
  .byte NOP, JMP
  .word syscall6
  .byte NOP, JMP
  .word syscall7
  .byte NOP, JMP
  .word syscall8
  .byte NOP, JMP
  .word syscall9
  .byte NOP, JMP
  .word syscallA
  .byte NOP, JMP
  .word syscallB
  .byte NOP, JMP
  .word syscallC
  .byte NOP, JMP
  .word syscallD
  .byte NOP, JMP
  .word syscallE
  .byte NOP, JMP
  .word syscallF
  .byte NOP, JMP
  .word syscall10
  .byte NOP, JMP
  .word securentr
  .byte NOP, JMP
  .word securexit
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
  .word syscall1A
  .byte NOP, JMP
  .word syscall1B
  .byte NOP, JMP
  .word syscall1C
  .byte NOP, JMP
  .word syscall1D
  .byte NOP, JMP
  .word syscall1E
  .byte NOP, JMP
  .word syscall1F
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
  .word syscall2A
  .byte NOP, JMP
  .word syscall2B
  .byte NOP, JMP
  .word syscall2C
  .byte NOP, JMP
  .word syscall2D
  .byte NOP, JMP
  .word syscall2E
  .byte NOP, JMP
  .word syscall2F
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
  .word syscall3A
  .byte NOP, JMP
  .word syscall3B
  .byte NOP, JMP
  .word syscall3C
  .byte NOP, JMP
  .word syscall3D
  .byte NOP, JMP
  .word syscall3E
  .byte NOP, JMP
  .word syscall3F
  .byte NOP
  .align $100
  TRAPS: .byte JMP
  .word main
  .byte NOP, JMP
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
