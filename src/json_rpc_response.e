note
	description: "[
		JSON RCP Response object.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_RESPONSE

feature -- Access

	jsonrpc: detachable STRING
		-- A String specifying the version of the JSON-RPC protocol. MUST be exactly "2.0".

	jresult: detachable ANY
		-- result
		-- This member is REQUIRED on success.
		-- This member MUST NOT exist if there was an error invoking the method.
		-- The value of this member is determined by the method invoked on the Server

	error: detachable JSON_RPC_ERROR
		-- This member is REQUIRED on error.
		-- This member MUST NOT exist if there was no error triggered during invocation.
		-- The value for this member MUST be an Object as defined in section 5.1.

	id: detachable JSON_RPC_ID
		-- This member is REQUIRED.
		-- It MUST be the same as the value of the id member in the Request Object.
		-- If there was an error in detecting the id in the Request object (e.g. Parse error/Invalid Request), it MUST be Null.

feature -- Change Element

	set_jsonrpc (a_value: like jsonrpc)
			-- Set `jsonrpc` with `a_value`.
		do
			jsonrpc := a_value
		ensure
			jsonrpc_set: jsonrpc = a_value
		end

	set_result (a_result: like jresult)
			-- Set `jresult` with `a_result`.
		do
			jresult := a_result
		ensure
			jresult_set: jresult = a_result
		end

	set_error (a_error: like error)
			-- Set `error` with `a_error`.
		do
			error := a_error
		ensure
			error_set: error = a_error
		end

	set_id (a_id: like id)
			-- Set `id` with `a_id`.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

end
