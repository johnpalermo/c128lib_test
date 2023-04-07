#import "common/lib/common-global.asm"
#import "framework/lib/string-global.asm"


//BasicUpstart2(start)  // 10 sys$0810
c128lib_BasicUpstart128(start)


string1: 
    .text "HELLO!"
    .byte 0,0,0,0,0,0,0,0,0,0,0,0
string2: 
    .text "HELLO!"
    .byte 0
string3:
    .text "0123456789"
string4:
    .text "0123456789"
string5:
    .text "0123456789"
string6:
    .text "0123456789"
string7:
    .text "0123456789"
string8:
    .text "0123456789"
string9:
    .text "0123456789"
string10:
    .text "0123456789"
string11: 
    .text "HELLO "
    .byte 0,0,0,0,0,0,0,0,0,0,0,0
string12: 
    .text "WORLD!"
    .byte 0
length:
    .byte 0
num_chars:
    .byte 0
start_pos:
    .byte 0


start:
    lda #<string1
    sta c128lib.String.STRING_SRC
    lda #>string1
    sta c128lib.String.STRING_SRC+1

    lda #<string2
    sta c128lib.String.STRING_TRG
    lda #>string2
    sta c128lib.String.STRING_TRG+1

// -----------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------
string_compare_test1:   
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
// -----------------------------------------------------------------------------------------------------
string_compare_test2:   
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
// -----------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------
string_length_test1:
    ldy #0 //clear Y
    lda #1 //clear Z flag
    // Y=0
    // Z=0,C=0
    // string1 = "HELLO!\0"
    // length= garbage
    @c128lib_StringLength(string1,false)
    sty length
    // Y=6
    // Z=1,C=0
    // string1 = "HELLO!\0"   
    // length=6
// -----------------------------------------------------------------------------------------------------
.break
string_length_test2:
    ldy #0 //clear Y
    lda #1 //clear Z flag
    sty length //clear length
    // Y=0
    // Z=0,C=0
    // string1 = "HELLO!\0"
    // length= garbage
    @c128lib_StringLength(c128lib.String.STRING_SRC,false)
    sty length
    // Y=6
    // Z=1,C=0
    // string1 = "HELLO!\0"   
    // length=6
// -----------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------
.break
string_copy_test1:
    ldy #0 //clear Y
    lda #1 //clear Z flag
    // Y=0
    // Z=0,C=0
    //string1 = "HELLO!\0"
    //string3 = "0123456789"
    @c128lib_StringCopy(string1,string3,false)
    // Y = 6
    // Z=1,C=0
    //string1 = "HELLO!\0"
    //string3 = "HELLO!\0"
// -----------------------------------------------------------------------------------------------------    
string_copy_test2:
    lda #<string4
    sta c128lib.String.STRING_TRG
    lda #>string4
    sta c128lib.String.STRING_TRG+1    

    ldy #0 //clear Y
    lda #1 //clear Z flag
    // Y=0
    // Z=0,C=0
    //string1 = "HELLO!\0"
    //string4 = "0123456789"
    @c128lib_StringCopy(c128lib.String.STRING_SRC,c128lib.String.STRING_TRG,false)
    // Y=6
    // Z=1,C=0
    //string1 = "HELLO!\0"
    //string4 = "HELLO!\0"
// -----------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------
string_copyleft_test1:
    lda #$03
    sta num_chars
    //string1 = "HELLO!\0"
    //string5 = "0123456789"   
    //num_chars = 3
    @c128lib_StringCopyLeft(string1,string5,num_chars,false)
    //string1 = "HELLO!\0"
    //string5 = "HEL\0"
    //num_chars = 3
string_copyleft_test2:
    lda #<string6
    sta c128lib.String.STRING_TRG
    lda #>string6
    sta c128lib.String.STRING_TRG+1    
// -----------------------------------------------------------------------------------------------------
    //string1 = "HELLO!\0"
    //string6 = "0123456789"   
    //num_chars = 3
    @c128lib_StringCopyLeft(c128lib.String.STRING_SRC,c128lib.String.STRING_TRG,num_chars,false)
    //string1 = "HELLO!\0"
    //string6 = "HEL\0"
    //num_chars = 3
// -----------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------
string_copyright_test1:
    //string1 = "HELLO!\0"
    //string7 = "0123456789"   
    //length = 6
    //num_chars = 3
    @c128lib_StringCopyRight(string1,string7,length, num_chars,false)
    //string1 = "HELLO!\0"
    //string7 = "LO!\0"
    //length = 6
    //num_chars = 3
// -----------------------------------------------------------------------------------------------------
string_copyright_test2:
    lda #<string8
    sta c128lib.String.STRING_TRG
    lda #>string8
    sta c128lib.String.STRING_TRG+1  
    //string1 = "HELLO!\0"
    //string8 = "0123456789"   
    //length = 6
    //num_chars = 3 
    @c128lib_StringCopyRight(c128lib.String.STRING_SRC,c128lib.String.STRING_TRG,length,num_chars,false)    
    //string1 = "HELLO!\0"
    //string8 = "LO!\0"
    //length = 6
    //num_chars = 3 
// -----------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------
string_copymid_test1:
    lda #1
    sta start_pos
    //string1 = "HELLO!\0"
    //string9 = "0123456789"   
    //start_pos = 1
    //num_chars = 3
    @c128lib_StringCopyMid(string1,string9,start_pos,num_chars,false)
    //string1 = "HELLO!\0"
    //string9 = "ELL\0"   
    //start_pos = 1
    //num_chars = 3
// -----------------------------------------------------------------------------------------------------
string_copymid_test2:
    lda #<string10
    sta c128lib.String.STRING_TRG
    lda #>string10
    sta c128lib.String.STRING_TRG+1  
    //string1 = "HELLO!\0"
    //string10 = "0123456789"   
    //start_pos = 1
    //num_chars = 3
    @c128lib_StringCopyMid(c128lib.String.STRING_SRC,c128lib.String.STRING_TRG,start_pos,num_chars,false)
    //string1 = "HELLO!\0"
    //string10 = "ELL\0"   
    //start_pos = 1
    //num_chars = 3
// -----------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------
string_concat_test1:
    //string1 = "HELLO!\0"
    //string2 = "HELLO!\0"  
    //length = 6
    // Make note of contents of $FA, $FB, $FC, $FD
    @c128lib_StringConcatenate(string1,string2,length,false)
    //string1 = "HELLO!HELLO!\0"
    //string2 = "HELLO!\0"  
    //length = 6 
    // Make note of contents of $FA, $FB, $FC, $FD and compare to before
// -----------------------------------------------------------------------------------------------------
string_concat_test2:
    lda #<string11
    sta c128lib.String.STRING_SRC
    lda #>string11
    sta c128lib.String.STRING_SRC+1

    lda #<string12
    sta c128lib.String.STRING_TRG
    lda #>string12
    sta c128lib.String.STRING_TRG+1

    //string11 = "HELLO \0"
    //string12 = "WORLD!\0"  
    //length = 6   
    // Make note of contents of $FA, $FB, $FC, $FD
    @c128lib_StringConcatenate(c128lib.String.STRING_SRC,c128lib.String.STRING_TRG,length,false)
    //string11 = "HELLO WORLD!\0"
    //string12 = "WORLD!\0"  
    //length = 6   
    // Make note of contents of $FA, $FB, $FC, $FD and compare to before

    jmp *  
