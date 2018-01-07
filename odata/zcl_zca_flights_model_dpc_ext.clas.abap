class ZCL_ZCA_FLIGHTS_MODEL_DPC_EXT definition
  public
  inheriting from ZCL_ZCA_FLIGHTS_MODEL_DPC
  create public .

public section.
protected section.

  methods AIRLINESET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZCA_FLIGHTS_MODEL_DPC_EXT IMPLEMENTATION.


  METHOD airlineset_get_entityset.

    DATA: lo_flights_bl TYPE REF TO zif_ca_flights_bl,
          lt_airlines    TYPE zca_airline_tt.

    lo_flights_bl = zcl_ca_flights_bl=>get_instance( ).

    lt_airlines = lo_flights_bl->get_airlines(  ).

    et_entityset[] = lt_airlines[].

  ENDMETHOD.
ENDCLASS.
