class ZCL_CA_FLIGHTS_BL definition
  public
  final
  create private .

public section.

  interfaces ZIF_CA_FLIGHTS_BL .

  methods CONSTRUCTOR
    importing
      !IO_FLIGHTS_DB type ref to ZIF_CA_FLIGHTS_DB
      !IO_POLICY_FACTORY type ref to ZIF_CA_POLICY_FACTORY .
  class-methods GET_INSTANCE
    returning
      value(RO_FLIGHT_BL) type ref to ZIF_CA_FLIGHTS_BL .
protected section.
private section.

  data MO_DATA_ACCESS type ref to ZIF_CA_FLIGHTS_DB .
  data MO_POLICY_FACTORY type ref to ZIF_CA_POLICY_FACTORY .
ENDCLASS.



CLASS ZCL_CA_FLIGHTS_BL IMPLEMENTATION.


  method CONSTRUCTOR.

    me->mo_data_access = io_flights_db.
    me->mo_policy_factory = io_policy_factory.

  endmethod.


  method GET_INSTANCE.
  endmethod.


  METHOD zif_ca_flights_bl~create_new_flight.


    TRY .

        mo_data_access->create_or_upd_flight(
          EXPORTING
            iv_airline_code      = is_flight_data-airline_code
            iv_flight_number     = is_flight_data-flight_number
            iv_flight_date       = is_flight_data-flight_date
            iv_flight_cost       = is_flight_data-flight_cost
            iv_flight_currency   = is_flight_data-flight_curr
            iv_plane_type        = is_flight_data-plane_type
        ).

      CATCH zcx_flights_db_error INTO DATA(lo_exception).

        APPEND VALUE bapiret2(
            type       = lo_exception->if_t100_dyn_msg~msgty
            id         = lo_exception->if_t100_message~t100key-msgid
            number     = lo_exception->if_t100_message~t100key-msgno
            message    = lo_exception->get_text( )
            message_v1 = lo_exception->if_t100_dyn_msg~msgv1
            message_v2 = lo_exception->if_t100_dyn_msg~msgv2
            message_v3 = lo_exception->if_t100_dyn_msg~msgv3
            message_v4 = lo_exception->if_t100_dyn_msg~msgv4
        ) TO rt_bapiret_messages .

    ENDTRY.

  ENDMETHOD.


  method ZIF_CA_FLIGHTS_BL~GET_AIRLINES.

    rt_airlines = mo_data_access->get_airlines(
        ir_airline_code = ir_airline_code
    ).

  endmethod.


  method ZIF_CA_FLIGHTS_BL~GET_FLIGHTS.

    rt_flights = mo_data_access->get_flights(
                 ir_airline_code  = ir_airline_code
                 ir_flight_number = ir_flight_number
                 ir_flight_date   = ir_flight_date
             ).

  endmethod.


  METHOD zif_ca_flights_bl~update_flight_price.

    DATA: lr_airline_code       TYPE mo_data_access->tr_airline_code,
          lr_flight_number      TYPE mo_data_access->tr_flight_number,
          lr_flight_date        TYPE mo_data_access->tr_flight_date,
          lt_flights            TYPE zca_flight_tt,
          ls_updated_flight     LIKE LINE OF lt_flights,
          lt_airlines           TYPE zca_airline_tt,
          ls_airline            LIKE LINE OF lt_airlines,
          lv_error_airline_desc TYPE string,
          lt_price_policies     TYPE zca_price_chng_policy_tt,
          ls_policy_result      TYPE bapiret2.

    lr_airline_code = VALUE #( ( sign = 'I' option = 'EQ' low = iv_airline_code ) ).
    lr_flight_number = VALUE #( ( sign = 'I' option = 'EQ' low = iv_flight_number ) ).
    lr_flight_date = VALUE #( ( sign = 'I' option = 'EQ' low = iv_flight_date ) ).

    lt_flights = mo_data_access->get_flights(
      EXPORTING
        ir_airline_code  = lr_airline_code
        ir_flight_number = lr_flight_number
        ir_flight_date   = lr_flight_date
    ).

    IF lt_flights IS INITIAL.

      lt_airlines = mo_data_access->get_airlines( ir_airline_code = lr_airline_code ).

      READ TABLE lt_airlines INDEX 1 INTO ls_airline.

      IF sy-subrc = 0.

        lv_error_airline_desc = ls_airline-airline_name.

      ENDIF.

      RAISE EXCEPTION TYPE zcx_flights_bl_error

      "No flight exist of airline &1 with number &2 on the date &3
      MESSAGE e000(zca_flights_bl_mc)
      WITH lv_error_airline_desc
           iv_flight_number
           iv_flight_date.
*

    ELSE.

      READ TABLE lt_flights INDEX 1 INTO ls_updated_flight.

      IF sy-subrc = 0.

        lt_price_policies =
          mo_policy_factory->get_price_policies_by_airline( iv_airline_code =  iv_airline_code ).

        LOOP AT lt_price_policies ASSIGNING FIELD-SYMBOL(<lo_policy>).

          ls_policy_result = <lo_policy>->validate_flight_price(
            EXPORTING
              is_flight_data     = ls_updated_flight
              iv_old_cost        = ls_updated_flight-flight_cost    " Airfare
              iv_new_cost        = iv_new_cost
          ).

          IF ls_policy_result-type = 'E'.

            APPEND ls_policy_result TO rt_bapiret_messages.

          ENDIF.

        ENDLOOP.

        CHECK rt_bapiret_messages IS INITIAL.

        ls_updated_flight-flight_cost = iv_new_cost.

        TRY .

            mo_data_access->create_or_upd_flight(
              EXPORTING
                iv_airline_code      = ls_updated_flight-airline_code
                iv_flight_number     = ls_updated_flight-flight_number
                iv_flight_date       = ls_updated_flight-flight_date
                iv_flight_cost       = ls_updated_flight-flight_cost
                iv_flight_currency   = ls_updated_flight-flight_curr
                iv_plane_type        = ls_updated_flight-plane_type
            ).

          CATCH zcx_flights_db_error INTO DATA(lo_exception).

            APPEND VALUE bapiret2(
                type       = lo_exception->if_t100_dyn_msg~msgty
                id         = lo_exception->if_t100_message~t100key-msgid
                number     = lo_exception->if_t100_message~t100key-msgno
                message    = lo_exception->get_text( )
                message_v1 = lo_exception->if_t100_dyn_msg~msgv1
                message_v2 = lo_exception->if_t100_dyn_msg~msgv2
                message_v3 = lo_exception->if_t100_dyn_msg~msgv3
                message_v4 = lo_exception->if_t100_dyn_msg~msgv4
            ) TO rt_bapiret_messages .

        ENDTRY.

      ENDIF.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
