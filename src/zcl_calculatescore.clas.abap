CLASS zcl_calculatescore DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_calculatescore IMPLEMENTATION.
  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA lt_original_data TYPE STANDARD TABLE OF ymdb_c_movie WITH DEFAULT KEY.
    lt_original_data = CORRESPONDING #( it_original_data ).



    LOOP AT it_requested_calc_elements INTO DATA(calc_elem).

      IF calc_elem EQ 'OVERALLSCORE'.


        SELECT FROM ymdb_i_wlist AS wlist
        INNER JOIN @lt_original_data AS orig
        ON wlist~MovieId EQ orig~MovieId
        FIELDS AVG( rating AS FLTP )  AS overallscore,
*    FIELDS wlist~Rating as overallscore,
        wlist~MovieId
        WHERE wlist~Rating <> 0
        GROUP BY wlist~MovieId
        INTO TABLE @DATA(movie_score).

        LOOP AT lt_original_data REFERENCE INTO DATA(orig).

          orig->OverallScore = VALUE #( movie_score[ MovieId = orig->MovieId ]-overallscore OPTIONAL ).

        ENDLOOP.
      ENDIF.

    ENDLOOP.


    ct_calculated_data = CORRESPONDING #( lt_original_data ).

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
*        LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_calc_element>).
*        CASE <fs_calc_element>.
*            WHEN 'OVERALLSCORE'.
*                APPEND '_WLIST' TO et_requested_orig_elements.
*        ENDCASE.
*    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
