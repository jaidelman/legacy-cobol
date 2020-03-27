*> sqrtbabyex.cob
*> Joshua Aidelman
*> 1000139
*> jaidelma@uoguelph.ca

IDENTIFICATION DIVISION.
PROGRAM-ID. SQRT.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT STANDARD-OUTPUT ASSIGN TO DISPLAY.
DATA DIVISION.
FILE SECTION.

*> To print output
FD STANDARD-OUTPUT.
    01 OUT-LINE  PICTURE X(80).

WORKING-STORAGE SECTION.

*> Variables for the sqrt calculation
77 DIFF PICTURE V9(5).
77 Z    PICTURE 9(11)V9(6).
77 K    PICTURE S9999.
77 X    PICTURE 9(11)V9(6).
77 Y    PICTURE 9(11)V9(6).
77 TEMP PICTURE 9(11)V9(6).

*> Variable to store the input
01 IN-CARD.
   02 IN-Z     PICTURE S9(10)V9(6) SIGN LEADING SEPARATE.
   02 IN-DIFF  PICTURE V9(5).
   02 FILLER   PICTURE X(58).

*> Line formats to be printed

*> Print Title
01 TITLE-LINE.
   02 FILLER PICTURE X(9) VALUE SPACES.
   02 FILLER PICTURE X(26) VALUE 'SQUARE ROOT APPROXIMATIONS'.

*> Print underline
01 UNDER-LINE.
   02 FILLER PICTURE X(44) VALUE
      '--------------------------------------------'.

*> Print line to ask user for input
01 INPUT-LINE.
   02 FILLER PICTURE X(37) VALUE 'Please enter any number or 0 to exit:'.
   02 FILLER PICTURE X(2) VALUE SPACES.

*> Print the square root calculation
01 PRINT-LINE.
   02 FILLER PICTURE X(19) VALUE 'The square root of '.
   02 OUT-Z  PICTURE Z(11)9.9(6).
   02 FILLER PICTURE X(4) VALUE ' is '.
   02 OUT-Y  PICTURE Z(11)9.9(6).

*> Print if there is an error
01 ERROR-MESS.
   02 OT-Z   PICTURE -(11)9.9(6).
   02 FILLER PICTURE X(55) VALUE ' is not a valid number. Please enter a positive number '.


*> Print if there are too many iterations
01 ABORT-MESS.
   02 FILLER PICTURE X VALUE SPACE.
   02 OUTP-Z PICTURE Z(11)9.9(6).
   02 FILLER PICTURE X(37) VALUE
      '  ATTEMPT ABORTED,TOO MANY ITERATIONS'.

*> Start procedure
PROCEDURE DIVISION.
    OPEN OUTPUT STANDARD-OUTPUT.
    WRITE OUT-LINE FROM TITLE-LINE AFTER ADVANCING 0 LINES.
    WRITE OUT-LINE FROM UNDER-LINE AFTER ADVANCING 1 LINE.

*> This function loops and asks the user to input a number, then approximates it's square root if it's a valid number
READLINE.
    COMPUTE IN-DIFF = 0.001.
    COMPUTE IN-Z = 1.
    PERFORM WITH TEST BEFORE UNTIL IN-Z = 0
      WRITE OUT-LINE FROM INPUT-LINE AFTER ADVANCING 1 LINE
      ACCEPT IN-Z
      IF IN-Z IS NOT GREATER THAN ZERO THEN
        *> If equal to 0, exit program
        IF IN-Z IS EQUAL TO 0
          STOP RUN
        *> If negative number, tell user invalid input
        ELSE
          MOVE IN-Z TO OT-Z
          WRITE OUT-LINE FROM ERROR-MESS AFTER ADVANCING 1 LINE
        END-IF
      *> If valid number, perform approximation
      ELSE
        CALL "extfunction" USING IN-Z, IN-DIFF
      END-IF
    END-PERFORM.
END-READLINE.
  PERFORM READLINE THRU END-READLINE.
