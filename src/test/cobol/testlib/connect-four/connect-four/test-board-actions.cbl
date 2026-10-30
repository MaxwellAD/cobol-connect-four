       IDENTIFICATION DIVISION. 
       PROGRAM-ID. TEST-BOARD-ACTIONS.
       ENVIRONMENT DIVISION.
       COPY CUTENV.
       DATA DIVISION.
       COPY CUTDATA.
       WORKING-STORAGE SECTION. 

       COPY STORAGE OF CONNECT-FOUR.
       COPY CUTSTOR.

       PROCEDURE DIVISION.

       TEST-TOKEN-DROPS-TO-BOTTOM SECTION.
           *> TEST THAT FOR AN EMPTY COLUMN THE TOKEN FALLS TO THE
           *> BOTTOM

           *> GIVEN
           MOVE 1 TO BOARD-COLUMN-SELECTED
           MOVE 'X' TO CURRENT-PLAYER

           *> WHEN
           PERFORM DROP-TOKEN
           
           *> THEN
           MOVE 'X' TO CUT-ASSERT-TARGET 
           MOVE GRID-CELL(1 6) TO CUT-ASSERT-ACTUAL 
           PERFORM CUT-ASSERT-EQUALS 


           PERFORM CUT-END-TEST 
       .

       TEST-TOKEN-IS-BLOCKED SECTION.
           *> TEST THAT A TOKEN IS BLOCKED ON ITS WAY TO THE BOTTOM
       
           *> GIVEN
           MOVE 1 TO BOARD-COLUMN-SELECTED 
           MOVE 'X' TO CURRENT-PLAYER
           *> PLAYER 0 TOKEN IN CELL 5, X SHOULD STOP AT ROW 4 
           MOVE '0' TO GRID-CELL(1 5)
       
           *> WHEN
           PERFORM DROP-TOKEN 
           
           *> THEN
           MOVE 'X' TO CUT-ASSERT-TARGET 
           MOVE GRID-CELL(1 4) TO CUT-ASSERT-ACTUAL
           PERFORM CUT-ASSERT-EQUALS            
       
           PERFORM CUT-END-TEST 
       .

       SKIP-REJECT-TKN-IN-FULL-COLUMN SECTION.
           *> WHEN A COLUMN IS FULL TO THE TOP A MOVE SHOULD BE REJECTED
       
           *> GIVEN
           MOVE 1 TO BOARD-COLUMN-SELECTED 
           MOVE 'X' TO CURRENT-PLAYER 
           MOVE '0' TO GRID-CELL(1 1)
       
           *> WHEN
           PERFORM DROP-TOKEN 
           
           *> THEN
           *> EXPECT-INVALID-MOVE
       
           PERFORM CUT-END-TEST 
       .
       

       END-TEST-SUITE SECTION.
           PERFORM DISPLAY-COVERAGE 
           PERFORM CUT-END-TEST-SUITE
       .
       
       
      *****************************************************************
      * RUNS AT THE TOP OF EACH SECTION IN THE SOURCE CODE
      * ADDS THE SPECIFIED FIELDS TO THE TRACE
      *
      *    USE THE FOLLOWING FORMAT TO REGISTER FIELDS
      *    MOVE 'FIELD-A' TO CUT-TEMP-FIELD-NAME 
      *    MOVE FIELD-A TO CUT-TEMP-FIELD-VALUE
      *    PERFORM CUT-REGISTER-FIELD 
      *
      *    ...
      *    
      *    MOVE 'FIELD-Z' TO CUT-TEMP-FIELD-NAME 
      *    MOVE FIELD-Z TO CUT-TEMP-FIELD-VALUE
      *    PERFORM CUT-REGISTER-FIELD 
      *
      *    EXIT SECTION
      *****************************************************************
       CUT-TRACE-FIELDS SECTION.
               MOVE CUT-RT-SECTION-COUNT TO CUT-TRACE-SECTION-INDEX
               MOVE CUT-RT-SECTION-FIELD-COUNT(CUT-RT-SECTION-COUNT) TO
                                                CUT-TRACE-FIELD-INDEX

           EXIT SECTION
       .

       COPY BOARD-MGT.

      *****************************************************************
      * RUNS BEFORE EACH TEST CASE
      * USE THIS SECTION TO SETUP AND TEARDOWN YOUR TEST DATA AND 
      * RESULTS
      * DO NOT REMOVE THE EXIT SECTION OTHERWISE YOU WILL FALL INTO
      * THE BUSINESS PROGRAM
      *****************************************************************
       BEFORE-EACH SECTION.
           PERFORM RESET-BOARD 
           EXIT SECTION 
       .

       COPY PROGRAM OF CONNECT-FOUR.
       COPY CUTPROC.
