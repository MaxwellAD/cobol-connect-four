       IDENTIFICATION DIVISION.
      ******************************************************************
       PROGRAM-ID.  CONNECT-FOUR.
       AUTHOR. MaxwellAD.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 CONNECT-FOUR-GRID.
           05 GIRD-COLUMNS OCCURS 7 TIMES.
               10 GRID-ROWS OCCURS 6 TIMES.
                   15 GRID-CELL PIC X.

       01 COUNTERS.
           05 GRID-X-COUNTER PIC 999.
           05 GRID-Y-COUNTER PIC 999.

       01 GAME-STATES.
           05 GAME-STATUS PIC X.
               88 GAME-STATUS-WIN VALUE 'W'.
               88 GAME-STATUS-DRAW VALUE 'D'.
           05 BOARD-COLUMN-SELECTED PIC 9.
           05 CURRENT-PLAYER PIC X.


       01 BUFFERS.
           05 DISPLAY-BUFFER PIC X(64).
           05 DISPLAY-OUTPUT-POINTER PIC 99. *> USED TO INDEX THE ABOVE

       PROCEDURE DIVISION.
       
       MAIN-ENTRY.
           PERFORM DRAW-TABLE 
           PERFORM EXIT-PROGRAM 
       .

       CHECK-FOR-WIN.
           EXIT PARAGRAPH 
       .
      
       DROP-TOKEN.
           PERFORM VARYING GRID-Y-COUNTER FROM 1 BY 1 UNTIL 
           GRID-Y-COUNTER > 6
               *> IF A TOKEN IS IN THIS SPACE
               IF GRID-CELL(BOARD-COLUMN-SELECTED GRID-Y-COUNTER) 
                   NOT = ' '
                   MOVE CURRENT-PLAYER TO GRID-CELL(
                             BOARD-COLUMN-SELECTED GRID-Y-COUNTER - 1) 
                   EXIT PERFORM 
               END-IF
               IF GRID-Y-COUNTER = 6
                   MOVE CURRENT-PLAYER TO 
                   GRID-CELL(BOARD-COLUMN-SELECTED GRID-Y-COUNTER )
               END-IF 
           END-PERFORM
           EXIT PARAGRAPH 
       .

       DRAW-TABLE.
           PERFORM VARYING GRID-Y-COUNTER FROM 1 BY 1 UNTIL 
           GRID-Y-COUNTER > 6
               MOVE 1 TO DISPLAY-OUTPUT-POINTER 
               PERFORM VARYING GRID-X-COUNTER FROM 1 BY 1 UNTIL 
               GRID-X-COUNTER > 7
                   STRING '|   ' DELIMITED BY SIZE INTO DISPLAY-BUFFER
                   WITH POINTER DISPLAY-OUTPUT-POINTER 
               END-PERFORM
               STRING '|' DELIMITED BY SIZE INTO DISPLAY-BUFFER 
               WITH POINTER DISPLAY-OUTPUT-POINTER 
               DISPLAY DISPLAY-BUFFER 
               MOVE 1 TO DISPLAY-OUTPUT-POINTER 
               PERFORM VARYING GRID-X-COUNTER FROM 1 BY 1 UNTIL 
               GRID-X-COUNTER > 7
                   STRING '----' DELIMITED BY SIZE INTO DISPLAY-BUFFER 
                   WITH POINTER DISPLAY-OUTPUT-POINTER 
               END-PERFORM
               STRING '-' DELIMITED BY SIZE INTO DISPLAY-BUFFER 
               WITH POINTER DISPLAY-OUTPUT-POINTER 
               DISPLAY DISPLAY-BUFFER 
           END-PERFORM
           EXIT PARAGRAPH 
       .

       EXIT-PROGRAM.
           DISPLAY 'FELL THROUGH'
           STOP RUN
       .
 