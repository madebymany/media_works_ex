defmodule MediaWorks.Store do
  defstruct [:store_id, :name, :id, :address, :company, :tax_id, :connected,
            :client_id, :contact_name, :contact_email, :is_24_hours,
            :installation_date, :request_count, :receipt_header,
            :receipt_footer, :working_hours_mon, :working_hours_tue,
            :working_hours_wed, :working_hours_thu, :working_hours_fri,
            :working_hours_sat, :working_hours_sun]
end