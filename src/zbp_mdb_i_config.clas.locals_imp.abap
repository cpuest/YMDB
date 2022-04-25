CLASS lhc_YMDB_I_CONFIG DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS delete_user FOR MODIFY
      IMPORTING keys FOR ACTION ymdb_i_config~delete_user.

    METHODS signin FOR MODIFY
      IMPORTING keys FOR ACTION ymdb_i_config~signin.

    METHODS signout FOR MODIFY
      IMPORTING keys FOR ACTION ymdb_i_config~signout.

    METHODS signup FOR MODIFY
      IMPORTING keys FOR ACTION ymdb_i_config~signup.

ENDCLASS.

CLASS lhc_YMDB_I_CONFIG IMPLEMENTATION.

  METHOD signup.

    TYPES: BEGIN OF config,
             uname_abap TYPE c LENGTH 12,
             user_name  TYPE c LENGTH 30,
             api_key    TYPE c LENGTH 20,
           END OF config.

    DATA: config TYPE config.

    DATA(uname) = cl_abap_context_info=>get_user_technical_name(  ).

    SELECT * FROM ymdb_i_config
    WHERE Uname_ABAP = @uname
    INTO TABLE @DATA(existent_user).

    IF existent_user IS INITIAL.

        LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).

          DATA(user_name) = <fs_key>-%param-user_name.
          DATA(api_key) = <fs_key>-%param-api_key.

        ENDLOOP.

        CHECK keys IS NOT INITIAL.

        config-uname_abap = uname.
        config-user_name = user_name.
        config-api_key = api_key.

        MODIFY ENTITY IN LOCAL MODE ymdb_i_config
        CREATE SET FIELDS WITH VALUE #( ( Uname_ABAP = config-uname_abap
                                          UserName = config-user_name
                                          ApiKey = config-api_key ) ).

    ENDIF.

  ENDMETHOD.

  METHOD delete_user.

    CHECK keys IS NOT INITIAL.

    DATA(uname) = cl_abap_context_info=>get_user_technical_name(  ).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).

      DATA(user_name) = <fs_key>-%param-user_name.

    ENDLOOP.

    MODIFY ENTITY IN LOCAL MODE ymdb_i_config
    DELETE FROM VALUE #( (  Uname_ABAP = uname
                            UserName = user_name ) ).

  ENDMETHOD.

  METHOD signin.

*    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).
*
*      DATA(user_name) = <fs_key>-%param-user_name.
*
*    ENDLOOP.
*
*    CHECK keys IS NOT INITIAL.
*
*    SELECT UserName, CurUser
*    FROM ymdb_i_config
*    WHERE CurUser = 'X' OR UserName = @user_name
*    INTO TABLE @DATA(changing).
*
*    LOOP AT changing ASSIGNING FIELD-SYMBOL(<line>).
*      IF <line>-CurUser = 'X'.
*        <line>-CurUser = ' '.
*      ENDIF.
*      IF <line>-UserName = user_name.
*        <line>-CurUser = 'X'.
*      ENDIF.
*    ENDLOOP.
*
*    MODIFY ENTITY IN LOCAL MODE ymdb_i_config
*    UPDATE FIELDS ( CurUser )
*    WITH CORRESPONDING #( changing ).

  ENDMETHOD.

  METHOD signout.

*    SELECT UserName, CurUser
*    FROM ymdb_i_config
*    WHERE CurUser = 'X'
*    INTO TABLE @DATA(active).
*
*    LOOP AT active ASSIGNING FIELD-SYMBOL(<line>).
*      <line>-CurUser = ' '.
*    ENDLOOP.
*
*    MODIFY ENTITY IN LOCAL MODE ymdb_i_config
*    UPDATE FIELDS ( CurUser )
*    WITH CORRESPONDING #( active ).

  ENDMETHOD.

ENDCLASS.
