*-----------------------------------------------------------
* Title      : K00280502_Repeat_Lab2
* Written by : K00280502
* Date       : 01/09/2024
* Description: Loops and Offsets
*-----------------------------------------------------------
      ORG    $1000               ; Program starts at memory location $1000

START:
    MOVE    #2000, A0          ; Initialize address register A0 to point to $2000 (start of storage)
    
READ_NUMBERS:
    MOVE    #17, D0            ; TRAP 17 to print the prompt message
    LEA     INPUT_MSG, A1
    TRAP    #15

    MOVE    #18, D0            ; TRAP 18 to read a number from the keyboard
    TRAP    #15
    MOVE.W  D1, (A0)           ; Store the number at the address pointed to by A0
    ADD.L  #2, A0             ; Increment the address by 2 (word size)


    CMP.W   #0, D1             ; Check if the entered number is 0
    BNE     READ_NUMBERS       ; If not 0, continue reading numbers

   SUB.L  #2, A0              ; Adjust A0 back to the last valid number location


SELECT_OPERATION:
    MOVE    #17, D0            ; Prompt the user for operation selection
    LEA     OPERATION_MSG, A1
    TRAP    #15

    MOVE    #18, D0            ; TRAP 18 to read the user's choice
    TRAP    #15
    MOVE.B  D1, D2             ; Store user selection in D2

    CMP.B   #'1', D2           ; Check if the user selected 1 (Multiply)
    BEQ     MULTIPLY_NUMBERS
    CMP.B   #'2', D2           ; Check if the user selected 2 (Add)
    BEQ     ADD_NUMBERS

    BRA     SELECT_OPERATION   ; If an invalid option is selected, prompt again

ADD_NUMBERS:
    MOVE.L  #0, D3             ; Initialize D3 to store the sum (start with 0)
    MOVEA.L A0, A1             ; Load the address of the last number into A1

SUM_LOOP:
    MOVE.W  (A1), D4           ; Load the current number from memory into D4
    ADD.W   D4, D3             ; Add the number to D3
    SUBQ.L  #2, A1             ; Move to the previous number in memory
    CMPA.L  #2000, A1          ; Check if we've reached the start of storage
    BGE     SUM_LOOP           ; If not, keep looping

    BRA     PRINT_RESULTS      ; Print the results

MULTIPLY_NUMBERS:
    MOVE.L  #1, D3             ; Initialize D3 to store the product (start with 1)
    MOVEA.L A0, A1             ; Load the address of the last number into A1

MUL_LOOP:
    MOVE.W  (A1), D4           ; Load the current number from memory into D4
    MULS    D4, D3             ; Multiply the number with D3
    SUBQ.L  #2, A1             ; Move to the previous number in memory
    MOVE.L  #2000, D0          ; Load the start address into D0
    CMPA.L  D0, A1             ; Compare A1 with the start of storage
    BGE     MUL_LOOP           ; If not, keep looping

PRINT_RESULTS:
    MOVEA.L A0, A1             ; Load the address of the last number into A1

PRINT_LOOP:
    MOVE.W  (A1), D4           ; Load the current number from memory into D4
    MOVE    #17, D0            ; Print "Num: " message
    LEA     NUM_MSG, A1
    TRAP    #15

    MOVE.W  D4, D1             ; Move the number to D1 for display
    MOVE    #14, D0            ; Use TRAP 14 to print number
    TRAP    #14                ; Print the number

    SUBQ.L  #2, A1             ; Move to the previous number in memory
    CMPA.L  #2000, A1          ; Check if we've reached the start of storage
    BGE     PRINT_LOOP         ; If not, keep looping

    ; Print the final result
    MOVE    #17, D0            ; Print result message
    LEA     RESULT_MSG, A1
    TRAP    #15

    MOVE.L  D3, D1             ; Move the result to D1 for display
    MOVE    #14, D0            ; Use TRAP 14 to print the result
    TRAP    #14                ; Print the result

    SIMHALT                    ; Halt the simulator

; Data section
INPUT_MSG:
    DC.B    'Enter a number (0 to finish): ', 0


OPERATION_MSG:
    DC.B    'Enter 1 to Multiply, 2 to Add: ', 0


NUM_MSG:
    DC.B    'Num: ', 0


RESULT_MSG:
    DC.B    'The result is: ', 0


    END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
