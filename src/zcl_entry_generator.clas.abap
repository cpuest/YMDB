CLASS zcl_entry_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_entry_generator IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    TYPEs: BEGIN OF trating,
*           rating TYPE ymdb_rating,
*    END OF TRATING.
*
*    DATA: line TYPE trating,
*          index TYPE i VALUE 1.
*
*    while index < 6.
*
*        line-rating = index.
*
*        INSERT ymdb_trating from @line.
*
*        index += 1.
*
*    ENDWHILE.

    out->write( sy-uname ).


  ENDMETHOD.

ENDCLASS.
