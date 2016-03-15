defmodule MediaWorks.DatapumpEvent do
  defstruct event_id: nil,
            pos_id: nil,
            event_type: nil,
            remote_host: nil,
            business_date: nil,
            timestamp: nil,
            hmac: nil
end
