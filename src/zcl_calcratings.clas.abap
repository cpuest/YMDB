CLASS zcl_calcratings DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_calcratings IMPLEMENTATION.
  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA lt_original_data TYPE STANDARD TABLE OF ymdb_c_person WITH DEFAULT KEY.
    lt_original_data = CORRESPONDING #( it_original_data ).

    SELECT FROM ymdb_i_wlist AS wlist
    INNER JOIN @lt_original_data AS orig
    ON wlist~PersonId EQ orig~PersonId
    FIELDS COUNT(*)  AS numRatings,
    wlist~PersonId, wlist~Rating
    WHERE wlist~Rating IS NOT INITIAL
    GROUP BY wlist~PersonId, wlist~Rating
    INTO TABLE @DATA(person_votes).

    LOOP AT lt_original_data REFERENCE INTO DATA(orig).

        orig->rating1 = VALUE #( person_votes[ PersonId = orig->PersonId Rating = '1' ]-numRatings OPTIONAL ).
        orig->rating2 = VALUE #( person_votes[ PersonId = orig->PersonId Rating = '2' ]-numRatings OPTIONAL ).
        orig->rating3 = VALUE #( person_votes[ PersonId = orig->PersonId Rating = '3' ]-numRatings OPTIONAL ).
        orig->rating4 = VALUE #( person_votes[ PersonId = orig->PersonId Rating = '4' ]-numRatings OPTIONAL ).
        orig->rating5 = VALUE #( person_votes[ PersonId = orig->PersonId Rating = '5' ]-numRatings OPTIONAL ).

    ENDLOOP.


    ct_calculated_data = CORRESPONDING #( lt_original_data ).
  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.

ENDCLASS.
