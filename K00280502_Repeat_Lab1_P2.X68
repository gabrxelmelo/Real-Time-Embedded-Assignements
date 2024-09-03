*-----------------------------------------------------------
* Title      : K00280502_Repeat_Lab1_P2
* Written by : K00280502
* Date       : 01/09/2024
* Description: Program 2 - Read 6 numbers, calculate and print the numbers and the result.
*-----------------------------------------------------------

    ORG    $1000               ; Program starts at memory location $1000

START:
    ; Prompt user to enter 6 numbers
    MOVE    #17, D0            ; TRAP 17 to print the prompt message
    LEA     PROMPT_MSG, A1
    TRAP    #15

    ; Read and store Num1
    MOVE    #17, D0            ; TRAP 17 to print the prompt for Num1
    LEA     NUM1_MSG, A1
    TRAP    #15
    MOVE    #18, D0            ; TRAP 18 to read the number
    TRAP    #15
    MOVE.W  D1, NUM1           ; Store the number in Num1

    ; Read and store Num2
    MOVE    #17, D0            ; TRAP 17 to print the prompt for Num2
    LEA     NUM2_MSG, A1
    TRAP    #15
    MOVE    #18, D0            ; TRAP 18 to read the number
    TRAP    #15
    MOVE.W  D1, NUM2           ; Store the number in Num2

    ; Read and store Num3
    MOVE    #17, D0            ; TRAP 17 to print the prompt for Num3
    LEA     NUM3_MSG, A1
    TRAP    #15
    MOVE    #18, D0            ; TRAP 18 to read the number
    TRAP    #15
    MOVE.W  D1, NUM3           ; Store the number in Num3

    ; Read and store Num4
    MOVE    #17, D0            ; TRAP 17 to print the prompt for Num4
    LEA     NUM4_MSG, A1
    TRAP    #15
    MOVE    #18, D0            ; TRAP 18 to read the number
    TRAP    #15
    MOVE.W  D1, NUM4           ; Store the number in Num4

    ; Read and store Num5
    MOVE    #17, D0            ; TRAP 17 to print the prompt for Num5
    LEA     NUM5_MSG, A1
    TRAP    #15
    MOVE    #18, D0            ; TRAP 18 to read the number
    TRAP    #15
    MOVE.W  D1, NUM5           ; Store the number in Num5

    ; Read and store Num6
    MOVE    #17, D0            ; TRAP 17 to print the prompt for Num6
    LEA     NUM6_MSG, A1
    TRAP    #15
    MOVE    #18, D0            ; TRAP 18 to read the number
    TRAP    #15
    MOVE.W  D1, NUM6           ; Store the number in Num6

    ; Perform the calculation (Num1*Num2) + (Num3*Num4) + (Num5*Num6)
    MOVE.W  NUM1, D5           ; Load Num1 into D5
    MULS    NUM2, D5           ; D5 = Num1 * Num2

    MOVE.W  NUM3, D6           ; Load Num3 into D6
    MULS    NUM4, D6           ; D6 = Num3 * Num4
    ADD.L   D6, D5             ; D5 = D5 + D6

    MOVE.W  NUM5, D7           ; Load Num5 into D7
    MULS    NUM6, D7           ; D7 = Num5 * Num6
    ADD.L   D7, D5             ; D5 = D5 + D7 (final result in D5)

    ; Print out the numbers and the answer
    MOVE    #17, D0            ; TRAP 17 to print Num1
    LEA     NUM1_MSG, A1
    TRAP    #15
    MOVE.W  NUM1, D1           ; Move Num1 into D1 for display
    MOVE    #14, D0            ; Use TRAP 14 to print number
    TRAP    #14                ; Print Num1

    MOVE    #17, D0            ; TRAP 17 to print Num2
    LEA     NUM2_MSG, A1
    TRAP    #15
    MOVE.W  NUM2, D1           ; Move Num2 into D1 for display
    MOVE    #14, D0            ; Use TRAP 14 to print number
    TRAP    #14                ; Print Num2

    MOVE    #17, D0            ; TRAP 17 to print Num3
    LEA     NUM3_MSG, A1
    TRAP    #15
    MOVE.W  NUM3, D1           ; Move Num3 into D1 for display
    MOVE    #14, D0            ; Use TRAP 14 to print number
    TRAP    #14                ; Print Num3

    MOVE    #17, D0            ; TRAP 17 to print Num4
    LEA     NUM4_MSG, A1
    TRAP    #15
    MOVE.W  NUM4, D1           ; Move Num4 into D1 for display
    MOVE    #14, D0            ; Use TRAP 14 to print number
    TRAP    #14                ; Print Num4

    MOVE    #17, D0            ; TRAP 17 to print Num5
    LEA     NUM5_MSG, A1
    TRAP    #15
    MOVE.W  NUM5, D1           ; Move Num5 into D1 for display
    MOVE    #14, D0            ; Use TRAP 14 to print number
    TRAP    #14                ; Print Num5

    MOVE    #17, D0            ; TRAP 17 to print Num6
    LEA     NUM6_MSG, A1
    TRAP    #15
    MOVE.W  NUM6, D1           ; Move Num6 into D1 for display
    MOVE    #14, D0            ; Use TRAP 14 to print number
    TRAP    #14                ; Print Num6

    ; Print the result
    MOVE    #17, D0            ; TRAP 17 to print the result message
    LEA     RESULT_MSG, A1
    TRAP    #15

    MOVE.L  D5, D1             ; Move the result into D1
    MOVE    #14, D0            ; Use TRAP 14 to print the result
    TRAP    #14                ; Print the result

    SIMHALT                    ; Halt the simulator

; Data section
PROMPT_MSG:
    DC.B    'Please enter 6 numbers.', 0

NUM1_MSG:
    DC.B    'Num1: ', 0

NUM2_MSG:
    DC.B    'Num2: ', 0

NUM3_MSG:
    DC.B    'Num3: ', 0

NUM4_MSG:
    DC.B    'Num4: ', 0

NUM5_MSG:
    DC.B    'Num5: ', 0

NUM6_MSG:
    DC.B    'Num6: ', 0

RESULT_MSG:
    DC.B    'The answer is: ', 0

; Storage for numbers
NUM1    DC.W    0
NUM2    DC.W    0
NUM3    DC.W    0
NUM4    DC.W    0
NUM5    DC.W    0
NUM6    DC.W    0

    END    START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
