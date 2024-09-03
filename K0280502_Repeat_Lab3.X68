*-----------------------------------------------------------
* Title      : 7 Segment Display Controller
* Written by : Gabriel Melo
* Date       : 02/09/2024
* Description: Display various messages on a 7-Segment Display.
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

*---------------------------------------------------------- 
* Display a digit on the 7-segment display 
* Pre:  D3.B contains 1 digit to display 
*       A2 points to 7-segment LED to use 
* Post: A2 points to next 7-segment LED 

    move.b  #32,d0          ; trap task to get address of hardware
    move.b  #0,d1           ; 0 in D1 means display
    trap    #15             ; display hardware window
    
    move.b  #1,d1           ; 1 in D1 means get address of 7-segment display
    trap    #15             ; get address of 7-segment display and store it in D1
    move.l  d1,a4           ; A4 = Address of 7-segment display
    move.l  a4,a2           ; Address of 7-segment display needs to be in A2 for segment7 subroutine

*------------ Display initial characters -----------

    move.b  #15,d3          ; display 'o'
    bsr     segment7
    
    move.b  #14,d3          ; display 'n'
    bsr     segment7
    
    move.b  #10,d3          ; display blank
    bsr     segment7
    
* Ask user to hit enter to continue
    move.b  #4,d0           ; prompt user to hit enter
    trap    #15

*------------ Display 'Standby' --------------------

    move.b  #12,d3          ; display 'S'
    bsr     segment7

    move.b  #13,d3          ; display 't'
    bsr     segment7

    move.b  #14,d3          ; display 'a'
    bsr     segment7

    move.b  #11,d3          ; display 'n'
    bsr     segment7
    
    move.b  #15,d3          ; display 'd'
    bsr     segment7
    
    move.b  #16,d3          ; display 'b'
    bsr     segment7

    move.b  #17,d3          ; display 'y'
    bsr     segment7

    move.b  #10,d3          ; display blank
    bsr     segment7

* Ask user to hit enter to continue
    move.b  #4,d0           ; prompt user to hit enter
    trap    #15

*------------ Display 'Power' --------------------

    move.b  #18,d3          ; display 'P'
    bsr     segment7

    move.b  #19,d3          ; display 'o'
    bsr     segment7

    move.b  #20,d3          ; display 'w'
    bsr     segment7

    move.b  #21,d3          ; display 'e'
    bsr     segment7

    move.b  #22,d3          ; display 'r'
    bsr     segment7

    move.b  #10,d3          ; display blank
    bsr     segment7

* Ask user to hit enter to continue
    move.b  #4,d0           ; prompt user to hit enter
    trap    #15

*------------ Display 'Ready' --------------------

    move.b  #23,d3          ; display 'R'
    bsr     segment7

    move.b  #21,d3          ; display 'e'
    bsr     segment7

    move.b  #25,d3          ; display 'a'
    bsr     segment7

    move.b  #26,d3          ; display 'd'
    bsr     segment7

    move.b  #17,d3          ; display 'y'
    bsr     segment7

    move.b  #10,d3          ; display blank
    bsr     segment7

* Ask user to hit enter to continue
    move.b  #4,d0           ; prompt user to hit enter
    trap    #15

*------------ Display First Name: Gabriel -----------------

    move.b  #23,d3          ; display 'G'
    bsr     segment7

    move.b  #25,d3          ; display 'a'
    bsr     segment7

    move.b  #24,d3          ; display 'b'
    bsr     segment7

    move.b  #28,d3          ; display 'r'
    bsr     segment7

    move.b  #21,d3          ; display 'i'
    bsr     segment7

    move.b  #35,d3          ; display 'e'
    bsr     segment7

    move.b  #37,d3          ; display 'l'
    bsr     segment7

    move.b  #10,d3          ; display blank
    bsr     segment7

* Ask user to hit enter to continue
    move.b  #4,d0           ; prompt user to hit enter
    trap    #15

*------------ Display Surname: Melo --------------------

    move.b  #34,d3          ; display 'M'
    bsr     segment7

    move.b  #35,d3          ; display 'e'
    bsr     segment7

    move.b  #37,d3          ; display 'l'
    bsr     segment7

    move.b  #19,d3          ; display 'o'
    bsr     segment7

    move.b  #10,d3          ; display blank
    bsr     segment7

* Ask user to hit enter to continue
    move.b  #4,d0           ; prompt user to hit enter
    trap    #15

*------------ Display K-Number: K00280502 -------------------

    move.b  #23,d3          ; display 'K'
    bsr     segment7

    move.b  #06,d3          ; display '0'
    bsr     segment7

    move.b  #06,d3          ; display '0'
    bsr     segment7

    move.b  #02,d3          ; display '2'
    bsr     segment7

    move.b  #08,d3          ; display '8'
    bsr     segment7

    move.b  #06,d3          ; display '0'
    bsr     segment7

    move.b  #05,d3          ; display '5'
    bsr     segment7

    move.b  #06,d3          ; display '0'
    bsr     segment7

    move.b  #02,d3          ; display '2'
    bsr     segment7

* Ask user to hit enter to continue
    move.b  #4,d0           ; prompt user to hit enter
    trap    #15

    MOVE.B  #9,D0           ; halt simulator
    TRAP    #15             ; halt instruction

* Subroutine to display a digit on the 7-segment display
segment7: 
    movem.l d3/a0,-(a7)     ; save registers 
    lea     digits,a0       ; load address of bit pattern array into A0 
    and.l   #$00ff,d3       ; force the top 8 bits of D3 to 0
    move.b  (a0,d3.w),d0    ; load digit bit pattern into d0 (use word indexing for array)
    move.b  d0,(a2)         ; display digit by placing in A2 the contents of A0 at index D3
    adda.l  #2,a2           ; move to next digit in 7-segment display
    movem.l (a7)+,d3/a0     ; restore registers 
    rts                     ; return from subroutine

* Bit patterns to form characters on the 7-segment display
digits: 
    dc.b  $3F           ; 0
    dc.b  $06           ; 1
    dc.b  $5B           ; 2
    dc.b  $4F           ; 3
    dc.b  $66           ; 4
    dc.b  $6D           ; 5
    dc.b  $7D           ; 6
    dc.b  $07           ; 7
    dc.b  $7F           ; 8
    dc.b  $6F           ; 9
    dc.b  $00           ; blank (off)
    dc.b  $40           ; dash (-)
    
    dc.b  $79           ; E
    dc.b  $76           ; H
    dc.b  $54           ; n
    dc.b  $5C           ; o
    dc.b  $5E           ; S
    dc.b  $73           ; t
    dc.b  $50           ; a
    dc.b  $6D           ; d
    dc.b  $1C           ; b
    dc.b  $0E           ; y
    dc.b  $4E           ; P
    dc.b  $38           ; w
    dc.b  $5D           ; r
    dc.b  $3F           ; R
    dc.b  $31           ; i
    dc.b  $70           ; c
    dc.b  $37           ; l
    dc.b  $67           ; N
    dc.b  $77           ; G
    dc.b  $3E           ; M
    dc.b  $79           ; e (reused)
    dc.b  $6D           ; 5 (reused)

    ds.w  0             ; force word boundary (always the last element in the array of digits)

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
