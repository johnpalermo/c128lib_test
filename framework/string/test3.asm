#import "common/lib/common-global.asm"
#import "framework/lib/string-global.asm"


//BasicUpstart2(start)  // 10 sys$0810
c128lib_BasicUpstart128(start)


string1: 
    .text "HELLO!"
    .byte 0,0,0,0,0,0,0,0,0,0,0,0

string2: 
    .text "HELLO WORLD!"
    .byte 0

start:
    lda #<string1
    sta c128lib.String.ZP_SRC
    lda #>string1
    sta c128lib.String.ZP_SRC+1

    lda #<string2
    sta c128lib.String.ZP_TRG
    lda #>string2
    sta c128lib.String.ZP_TRG+1

string_compare_test1:   
    ldy #0
    // Y=0
    // Z=0,C=0
    // string1 = "HELLO!\0"
    // string2 = "HELLO WORLD!"
    @c128lib_StringCompare(string1,string2,false)
    // Z=0,C=0
    // Y=5
    // string1 = "HELLO!\0"
    // string2 = "HELLO WORLD!"
.break
string_compare_test2:   
    ldy #0 //clear Y
    lda #1 //clear Z flag
    // Y=0
    // Z=0,C=0
    // string1 = "HELLO!\0"
    // string2 = "HELLO WORLD!"
    @c128lib_StringCompare(c128lib.String.ZP_SRC,c128lib.String.ZP_TRG,false)
    // Z=0,C=0
    // Y=5
    // string1 = "HELLO!\0"
    // string2 = "HELLO WORLD!"

.break
jmp *