*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_not_free DEFINITION.
  PUBLIC SECTION.
    INTERFACES zif_ca_price_chng_policy.
ENDCLASS.

CLASS lcl_not_free IMPLEMENTATION.
  METHOD zif_ca_price_chng_policy~validate_flight_price.

    IF iv_new_cost IS INITIAL.

      MESSAGE e001(zca_flights_bl_mc) INTO DATA(lv_message_text).

      rs_bapiret_message = VALUE bapiret2(
          type       = sy-msgty
          id         = sy-msgid
          number     = sy-msgno
          message    = lv_message_text
      ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
