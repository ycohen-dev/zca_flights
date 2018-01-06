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

      "Flight tickets cannot be free
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

CLASS lcl_bound_precentage_change DEFINITION.
  PUBLIC SECTION.
    INTERFACES zif_ca_price_chng_policy.
    METHODS constructor
      IMPORTING iv_max_precent_delta TYPE numc3.
  PRIVATE SECTION.
    DATA: mv_max_precent_delta TYPE numc3.
ENDCLASS.
CLASS lcl_bound_precentage_change IMPLEMENTATION.
  METHOD constructor.
    mv_max_precent_delta = iv_max_precent_delta.
  ENDMETHOD.

  METHOD zif_ca_price_chng_policy~validate_flight_price.

    DATA: lv_price_delta         TYPE i,
          lv_delta_in_precentage TYPE i.

    CHECK iv_new_cost <> iv_old_cost AND
          iv_old_cost IS NOT INITIAL.

    IF iv_old_cost > iv_new_cost.

      lv_price_delta = iv_old_cost - iv_new_cost.

    ELSE.

      lv_price_delta = iv_new_cost - iv_old_cost.

    ENDIF.

    lv_delta_in_precentage = lv_price_delta / iv_old_cost.
    lv_delta_in_precentage = lv_delta_in_precentage * 100.

    IF lv_delta_in_precentage > mv_max_precent_delta.

      "Price diffrence cannot top &1 precent
      MESSAGE e002(zca_flights_bl_mc)
      WITH mv_max_precent_delta
      INTO DATA(lv_message_text).

      rs_bapiret_message = VALUE bapiret2(
          type       = sy-msgty
          id         = sy-msgid
          number     = sy-msgno
          message    = lv_message_text
          message_v1 = sy-msgv1
      ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
