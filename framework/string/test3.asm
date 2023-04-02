#import "framework/lib/string-global.asm"


BasicUpstart2(start)  // 10 sys$0810


string1: 
    .text "HELLO!"
    .byte 0,0,0,0,0,0,0,0,0,0,0,0

string2: 
    .text "HELLO WORLD!"
    .byte 0

.break
start:
    lda #<string1
    sta c128lib.String.STRING_SRC
    lda #>string1
    sta c128lib.String.STRING_SRC+1

    lda #<string2
    sta c128lib.String.STRING_TRG
    lda #>string2
    sta c128lib.String.STRING_TRG+1

string_compare_test1:   
.break
    ldy #0
    // Y=0
    // Z=0,C=0
    // string1 = "HELLO!\0"
    // string2 = "HELLO!\0"
    @c128lib_StringCompare(string1,string2,false)
    // Z=1,C=0
    // Y=6
    // string1 = "HELLO!\0"
    // string2 = "HELLO!\0"
string_compare_test2:   
.break
    ldy #0 //clear Y
    lda #1 //clear Z flag
    // Y=0
    // Z=0,C=0
    // string1 = "HELLO!\0"
    // string2 = "HELLO!\0"
    @c128lib_StringCompare(c128lib.String.STRING_SRC,c128lib.String.STRING_TRG,false)
    // Z=1,C=0
    // Y=6
    // string1 = "HELLO!\0"
    // string2 = "HELLO!\0"

