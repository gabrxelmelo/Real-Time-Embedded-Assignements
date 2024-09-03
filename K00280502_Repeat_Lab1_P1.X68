*-----------------------------------------------------------
* Title      : Lab 1 Repeat Program 1
* Written by : K00280502
* Date       : 01/09/2024
* Description: Calculator
*-----------------------------------------------------------
           ORG    $1000               ; Program starts at memory location $1000

START:
    MOVE    #17, D0            ; TRAP 17 for printing the initial message
    LEA     WELCOME_MSG, A1
    TRAP    #15

MENU_LOOP:
    MOVE    #17, D0            ; TRAP 17 to print the menu
    LEA     MENU, A1
    TRAP    #15

    MOVE    #18, D0            ; TRAP 18 for reading user input
    TRAP    #15
    MOVE.B  D1, D4             ; Store option in D4

    CMP.B   #'1', D4           ; Check if option 1 is selected
    BEQ     OPTION_1
    CMP.B   #'2', D4           ; Check if option 2 is selected
    BEQ     OPTION_2
    CMP.B   #'3', D4           ; Check if option 3 is selected
    BEQ     EXIT_PROGRAM

    ; Invalid option selected
    
    MOVE    #17, D0            ; TRAP 17 to print the invalid option message
    LEA     INVALID_MSG, A1
    TRAP    #15
    BRA     MENU_LOOP          ; Loop back to the menu

OPTION_1:
    MOVE    #17, D0            ; Prompt for the first number
    LEA     FIRST_NUM_MSG, A1
    TRAP    #15
    MOVE    #18, D0            ; Read the first number
    TRAP    #15
    MOVE.W  D1, D5             ; Store first number in D5

    MOVE    #17, D0            ; Prompt for the second number
    LEA     SECOND_NUM_MSG, A1
    TRAP    #15
    MOVE    #18, D0            ; Read the second number
    TRAP    #15
    MOVE.W  D1, D6             ; Store second number in D6

    MULS    D6, D5             ; Multiply D5 by D6 (result in D5)
    MOVE    #17, D0            ; Display the result
    LEA     PRODUCT_MSG, A1
    TRAP    #15

    MOVE    D5, D1             ; Move the product to D1 for display
    CLR     D0                 ; Clear D0 before calling TRAP 14
    TRAP    #14                ; TRAP 14 to print the number

    BRA     MENU_LOOP          ; Loop back to the menu

OPTION_2:
    MOVE    #17, D0            ; Prompt for the first number
    LEA     FIRST_NUM_MSG, A1
    TRAP    #15
    MOVE    #18, D0            ; Read the first number
    TRAP    #15
    MOVE.W  D1, D5             ; Store first number in D5

    MOVE    #17, D0            ; Prompt for the second number
    LEA     SECOND_NUM_MSG, A1
    TRAP    #15
    MOVE    #18, D0            ; Read the second number
    TRAP    #15
    MOVE.W  D1, D6             ; Store second number in D6

    DIVS    D6, D5             ; Divide D5 by D6 (D5 = quotient, remainder in D5 high word)
    MOVE    #17, D0            ; Display the quotient
    LEA     QUOTIENT_MSG, A1
    TRAP    #15

    MOVE    D5, D1             ; Move the quotient to D1 for display
    CLR     D0                 ; Clear D0 before calling TRAP 14
    TRAP    #14                ; TRAP 14 to print the quotient

    MOVE    #17, D0            ; Print remainder message
    LEA     REMAINDER_MSG, A1
    TRAP    #15

    SWAP    D5                 ; Swap high and low words to get the remainder in the low word
    MOVE    D5, D1             ; Move the remainder to D1 for display
    CLR     D0                 ; Clear D0 before calling TRAP 14
    TRAP    #14                ; TRAP 14 to print the remainder

    BRA     MENU_LOOP          ; Loop back to the menu

EXIT_PROGRAM:
    MOVE    #17, D0            ; TRAP 17 to print exit message
    LEA     EXIT_MSG, A1
    TRAP    #15

    SIMHALT                    ; Halt the simulator (or replace with BRA * for infinite loop)

WELCOME_MSG:
    DC.B    'Welcome to my Calculator ', 0

MENU:
    DC.B    '1. Multiply 2 numbers ', 0
    DC.B    '2. Divide 2 numbers ', 0
    DC.B    '3. Exit Program ', 0
    DC.B    'Select an option:  ', 0

INVALID_MSG:                    ; Label for invalid message
    DC.B    'Invalid option. Try again. ', 0

FIRST_NUM_MSG:                   ; Label for first number prompt
    DC.B    'Enter the first number: ' , 0

SECOND_NUM_MSG:                  ; Label for second number prompt
    DC.B    'Enter the second number: ' , 0

PRODUCT_MSG:                     ; Label for product result message
    DC.B    'The product of the numbers is: ' , 0

QUOTIENT_MSG:                    ; Label for quotient result message
    DC.B    'The Quotient is ' , 0

REMAINDER_MSG:                   ; Label for remainder result message
    DC.B    ' the remainder is ' , 0

EXIT_MSG:                        ; Label for exit message
    DC.B    'Exiting the program.' , 0

    END    START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
