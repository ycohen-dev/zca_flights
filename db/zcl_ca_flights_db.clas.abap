CLASS zcl_ca_flights_db DEFINITION
  PUBLIC
  FINAL
  CREATE PROTECTED .

  PUBLIC SECTION.

    INTERFACES zif_ca_flights_db .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CA_FLIGHTS_DB IMPLEMENTATION.


  METHOD zif_ca_flights_db~create_flight.

    DATA: ls_bapi_flight TYPE bapisflrep,
          lt_bapiret2    TYPE bapiret2_t,
          ls_bapiret2    LIKE LINE OF lt_bapiret2.

    ls_bapi_flight-airlineid = iv_airline_code.
    ls_bapi_flight-connectid = iv_flight_number.
    ls_bapi_flight-flightdate = iv_flight_date.
    ls_bapi_flight-price = iv_flight_cost.
    ls_bapi_flight-curr = iv_flight_currency.
    ls_bapi_flight-planetype = iv_plane_type.

    CALL FUNCTION 'BAPI_FLIGHT_SAVEREPLICA'
      EXPORTING
        flight_data = ls_bapi_flight
*       TEST_RUN    = ' '
      TABLES
*       EXTENSION_IN       =
        return      = lt_bapiret2.


    READ TABLE lt_bapiret2
    WITH KEY type = 'E'
    INTO ls_bapiret2.

    IF sy-subrc = 0.

      RAISE EXCEPTION TYPE zcx_flights_db_error
      MESSAGE id ls_bapiret2-id
      TYPE ls_bapiret2-type
      NUMBER ls_bapiret2-number
      WITH  ls_bapiret2-message_v1
            ls_bapiret2-message_v2
            ls_bapiret2-message_v3
            ls_bapiret2-message_v4.

    ENDIF.

  ENDMETHOD.


  METHOD zif_ca_flights_db~get_airlines.

    SELECT  carrid    AS airline_code,
            carrname  AS airline_name,
            url       AS airline_url
    FROM    scarr
    INTO CORRESPONDING FIELDS OF TABLE @rt_airlines
    WHERE carrid IN @ir_airline_code.

  ENDMETHOD.


  METHOD zif_ca_flights_db~get_flights.

    TYPES: BEGIN OF ts_flight_data,
             carrid     TYPE sflight-carrid,
             connid     TYPE sflight-connid,
             fldate     TYPE sflight-fldate,
             price      TYPE sflight-price,
             currency   TYPE sflight-currency,
             planetype  TYPE sflight-planetype,
             seatsmax   TYPE sflight-seatsmax,
             seatsocc   TYPE sflight-seatsocc,
             seatsmax_b TYPE sflight-seatsmax_b,
             seatsocc_b TYPE sflight-seatsocc_b,
             seatsmax_f TYPE sflight-seatsmax_f,
             seatsocc_f TYPE sflight-seatsocc_f,
             countryfr  TYPE spfli-countryfr,
             countryto  TYPE spfli-countryto,
           END OF ts_flight_data,

           tt_flight_data TYPE STANDARD TABLE OF ts_flight_data WITH DEFAULT KEY.


    DATA: lt_flights      TYPE tt_flight_data,
          lt_countries    TYPE SORTED TABLE OF t005t WITH UNIQUE KEY land1,
          ls_countries    LIKE LINE OF lt_countries,
          ls_flight_final LIKE LINE OF rt_flights.

    SELECT  flt~carrid,
            flt~connid,
            flt~fldate,
            flt~price,
            flt~currency,
            flt~planetype,
            flt~seatsmax,
            flt~seatsocc,
            flt~seatsmax_b,
            flt~seatsocc_b,
            flt~seatsmax_f,
            flt~seatsocc_f,
            fls~countryfr,
            fls~countryto
    FROM  sflight AS flt
          LEFT OUTER JOIN
          spfli AS fls
          ON ( flt~carrid = fls~carrid AND
               flt~connid = fls~connid )
    INTO CORRESPONDING FIELDS OF TABLE @lt_flights
    WHERE flt~carrid   IN @ir_airline_code
    AND   flt~connid   IN @ir_flight_number
    AND   flt~fldate   IN @ir_flight_date.

    IF sy-subrc = 0.

      SELECT land1,
             landx
      FROM t005t
      INTO CORRESPONDING FIELDS OF TABLE @lt_countries
      WHERE spras = @sy-langu.

      IF sy-subrc = 0.

        LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<ls_flight>).

          CLEAR ls_flight_final.

          ls_flight_final = VALUE zca_flight_st(
              airline_code  = <ls_flight>-carrid
              flight_number = <ls_flight>-connid
              flight_date   = <ls_flight>-fldate
              flight_cost   = <ls_flight>-price
              flight_curr   = <ls_flight>-currency
              plane_type    = <ls_flight>-planetype
              max_seats_eco = <ls_flight>-seatsmax
              occ_seats_eco = <ls_flight>-seatsocc
              max_seats_bus = <ls_flight>-seatsocc_b
              occ_seats_bus = <ls_flight>-seatsocc_b
              max_seats_fcl = <ls_flight>-seatsmax_f
              occ_seats_fcl = <ls_flight>-seatsocc_f
          ).

          READ TABLE lt_countries
          WITH KEY land1 = <ls_flight>-countryfr
          INTO ls_countries.

          IF sy-subrc = 0.

            ls_flight_final-country_from = ls_countries-landx.

          ENDIF.

          READ TABLE lt_countries
          WITH KEY land1 = <ls_flight>-countryto
          INTO ls_countries.

          IF sy-subrc = 0.

            ls_flight_final-country_to = ls_countries-landx.

          ENDIF.

          APPEND ls_flight_final TO rt_flights.

        ENDLOOP.

      ENDIF.

    ENDIF.

  ENDMETHOD.


  method ZIF_CA_FLIGHTS_DB~UPDATE_FLIGHT.
  endmethod.
ENDCLASS.
