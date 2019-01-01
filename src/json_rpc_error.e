note
	description: "[
			Error object
			When a rpc call encounters an error, the Response Object MUST contain the error member with a value that is a Object with the following members:
		
		code		message				meaning
		-32700		Parse error			Invalid JSON was received by the server.
										An error occurred on the server while parsing the JSON text.

		-32600		Invalid Request		The JSON sent is not a valid Request object.
		-32601		Method not found	The method does not exist / is not available.
		-32602		Invalid params		Invalid method parameter(s).
		-32603		Internal error		Internal JSON-RPC error.
		-32000 to 
		-32099		Server error		Reserved for implementation-defined server-errors.

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_ERROR


create
	make

feature {NONE} -- Initialization

	make (a_code: INTEGER; a_message: STRING)
			-- Create an object error with code `a_code` and message `a_message`.
		do
			code := a_code
			message := a_message
		ensure
			code_set: code = a_code
			message_set: message = a_message
		end

feature -- Access

	code: INTEGER
		-- A Number that indicates the error type that occurred.

	message: STRING
		--  String providing a short description of the error.

	data: detachable STRING
		-- A Primitive or Structured value that contains additional information about the error.

feature -- Change Element

	set_data (a_data: like data)
			-- Set `data` with `a_data`.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end
end
