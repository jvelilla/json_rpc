note
	description: "Messages and descriptions associated with JSON RPC errors."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_ERROR_NAMES

feature -- Access
	
	message (a_error: INTEGER): STRING
		do
			inspect
				a_error
			when -32700 then Result := "Parse error"
			when -32600 then Result := "Invalid Request"
			when -32601 then Result := "Method not found"
			when -32602 then Result := "Invalid params"
			when -32603 then Result := "Internal error"
			when -32000 .. -32099 then 
				Result := "Server error"
			else
				Result := "Error code:" + a_error.out
			end
		end

	description (a_error: INTEGER): STRING
		do
			inspect
				a_error
			when -32700 then Result := "[
							Invalid JSON was received by the server.
							An error occurred on the server while parsing the JSON text.
							]"
			when -32600 then Result := "The JSON sent is not a valid Request object."
			when -32601 then Result := "The method does not exist / is not available."
			when -32602 then Result := "Invalid method parameter(s)."
			when -32603 then Result := "Internal JSON-RPC error"
			when -32000 .. -32099 then 
				Result := "Reserved for implementation-defined server-errors."
			else
				Result := message (a_error)
			end
		end

end
