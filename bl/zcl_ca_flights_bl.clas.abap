class ZCL_CA_FLIGHTS_BL definition
  public
  final
  create public .

public section.

  interfaces ZIF_CA_FLIGHTS_BL .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CA_FLIGHTS_BL IMPLEMENTATION.


  method ZIF_CA_FLIGHTS_BL~CREATE_NEW_FLIGHT.
  endmethod.


  method ZIF_CA_FLIGHTS_BL~GET_AIRLINES.
  endmethod.


  method ZIF_CA_FLIGHTS_BL~GET_FLIGHTS.
  endmethod.


  method ZIF_CA_FLIGHTS_BL~UPDATE_FLIGHT_PRICE.
  endmethod.
ENDCLASS.
