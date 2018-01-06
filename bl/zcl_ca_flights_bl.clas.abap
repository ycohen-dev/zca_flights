class ZCL_CA_FLIGHTS_BL definition
  public
  final
  create public .

public section.

  interfaces ZIF_CA_FLIGHTS_BL .

  methods CONSTRUCTOR
    importing
      !IO_FLIGHTS_DB type ref to ZIF_CA_FLIGHTS_DB .
protected section.
private section.

  data MO_DATA_ACCESS type ref to ZIF_CA_FLIGHTS_DB .
ENDCLASS.



CLASS ZCL_CA_FLIGHTS_BL IMPLEMENTATION.


  method CONSTRUCTOR.

    me->mo_data_access = io_flights_db.

  endmethod.


  method ZIF_CA_FLIGHTS_BL~CREATE_NEW_FLIGHT.
  endmethod.


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
          lv_error_airline_desc TYPE string.

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

*            io_message_container->a

        ENDTRY.

      ENDIF.


    ENDIF.

  ENDMETHOD.
ENDCLASS.
