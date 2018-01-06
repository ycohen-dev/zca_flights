interface ZIF_CA_POLICY_FACTORY
  public .


  methods GET_PRICE_POLICIES_BY_AIRLINE
    importing
      !IV_AIRLINE_CODE type ZCA_AIRLINE_ST-AIRLINE_CODE
    returning
      value(RT_POLICIES) type ZCA_PRICE_CHNG_POLICY_TT .
endinterface.
