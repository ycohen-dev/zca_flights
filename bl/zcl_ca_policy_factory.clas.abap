class ZCL_CA_POLICY_FACTORY definition
  public
  final
  create public .

public section.

  interfaces ZIF_CA_POLICY_FACTORY .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CA_POLICY_FACTORY IMPLEMENTATION.


  method ZIF_CA_POLICY_FACTORY~GET_PRICE_POLICIES_BY_AIRLINE.

    APPEND NEW lcl_not_free( ) TO rt_policies.

  endmethod.
ENDCLASS.
