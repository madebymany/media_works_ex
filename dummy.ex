order = %MediaWorks.Order{
  order_id: "TEST-1234",
  state_id: "5",
  state: "PAID",
  type_id: "0",
  type: "SALE",
  custom_order_properties: %{
    current_store: "71",
    ready_date_time: "2016-02-09T13:00:00"
  },
  sale_lines: [
    %{level: "0",
      line_number: "0",
      product_code: "1010",
      multiplied_qty: "1",
      qty: "1"}
  ],
  tenders: [
    %{tender_id: "45",
      tender_type: "1",
      tender_desc: "CREDIT_CARD",
      tender_amount: "100.00"}
  ]
}

# {
#   "order":{
#     "typeId":"0",
#     "type":"SALE",
#     "stateId":"5",
#     "state":"PAID",
#     "orderId":"TEST-1234",
#     "customOrderProperties":{
#       "readyDateTime":"2016-02-09T13:00:00",
#       "currentStore":"71"
#     }
#   },
#   "tender":[
#     {"tenderType":"1","tenderId":"45","tenderDesc":"CREDIT_CARD","tenderAmount":"100.00"}
#   ],
#   "saleLine":[
#     {"qty":"1","productCode":"1010","multipliedQty":"1","lineNumber":"0","level":"0"}
#   ]
# }

