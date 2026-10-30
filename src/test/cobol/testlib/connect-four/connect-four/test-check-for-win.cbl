       IDENTIFICATION DIVISION. 
       PROGRAM-ID. TEST-CHECK-FOR-WIN.
       ENVIRONMENT DIVISION.
       COPY CUTENV.
       DATA DIVISION.
       COPY CUTDATA.
       WORKING-STORAGE SECTION. 

       COPY STORAGE OF CONNECT-FOUR.
       COPY CUTSTOR.

       PROCEDURE DIVISION.

       SKIP-WIN-4-VERTICAL SECTION.
           *> TEST THE THE WIN PARAGRAPH CAN DETECT A WIN WITH 4 IN A
           *> ROW VERTICALLY

           *> GIVEN
           MOVE 'X' TO GRID-CELL(1 6)
           MOVE 'X' TO GRID-CELL(1 5)
           MOVE 'X' TO GRID-CELL(1 4)
           MOVE 'X' TO GRID-CELL(1 3)

           *> WHEN
           PERFORM CHECK-FOR-WIN  
           
           *> THEN
           PERFORM EXPECT-WIN


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

       EXPECT-WIN SECTION.
           IF NOT GAME-STATUS-WIN
               STRING 'EXPECTED GAME STATUS TO BE WIN BUT WAS ' 
               GAME-STATUS DELIMITED BY SIZE INTO CUT-DISPLAY-FAIL-MSG  
               PERFORM CUT-FAIL 
           END-IF
       .

      *****************************************************************
      * RUNS BEFORE EACH TEST CASE
      * USE THIS SECTION TO SETUP AND TEARDOWN YOUR TEST DATA AND 
      * RESULTS
      * DO NOT REMOVE THE EXIT SECTION OTHERWISE YOU WILL FALL INTO
      * THE BUSINESS PROGRAM
      *****************************************************************
       BEFORE-EACH SECTION.
           EXIT SECTION  
       .



       COPY PROGRAM OF CONNECT-FOUR.
       COPY CUTPROC.
