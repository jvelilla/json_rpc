note
	description: "[
		JSON RPC Request object. 
		JSON-RPC is a stateless, light-weight remote procedure call (RPC) protocol.
		Supported version 2.0
			
		Example:
		{"jsonrpc": "2.0", "method": "subtract", "params": {"minuend": 42, "subtrahend": 23}, "id": 3}
		
		{"jsonrpc": "2.0", "method": "subtract", "params": [23, 42], "id": 2}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=jsonrcp spec", "src=https://www.jsonrpc.org/specification", "protocol=uri"

class
	JSON_RPC_REQUEST


feature -- Access

	jsonrpc: detachable STRING
		-- A String specifying the version of the JSON-RPC protocol. MUST be exactly "2.0".

	method: detachable STRING_32
		-- A String containing the name of the method to be invoked.
		-- Method names that begin with the word rpc followed by a period character (U+002E or ASCII 46) are reserved
		-- for rpc-internal methods and extensions and MUST NOT be used for anything else.		

	params: detachable JSON_RPC_PARAMS
		-- A Structured value that holds the parameter values to be used during the invocation of the method.
		-- This member MAY be omitted.

	id: detachable JSON_RPC_ID
		-- An identifier established by the Client that MUST contain a String, Number, or NULL value if included.
		-- If it is not included it is assumed to be a notification. The value SHOULD normally not be Null [1] and Numbers SHOULD NOT contain fractional parts [2]
		-- The Server MUST reply with the same value in the Response object if included. This member is used to correlate the context between the two objects.
		-- [1] The use of Null as a value for the id member in a Request object is discouraged, because this specification uses a value of Null for Responses with an unknown id.
		-- Also, because JSON-RPC 1.0 uses an id value of Null for Notifications this could cause confusion in handling.
		-- [2] Fractional parts may be problematic, since many decimal fractions cannot be represented exactly as binary fractions.


feature -- Change Element

	set_jsonrpc (a_val: like jsonrpc)
			-- Set `jsonrpc` with `a_val`.
		do
			jsonrpc := a_val
		ensure
			jsonrpc_set: jsonrpc = a_val
		end

	set_method (a_val: like method)
			-- Set `method` with `a_val`.
		do
			method := a_val
		ensure
			method_set: method = a_val
		end

	set_params (a_params: like params)
			-- Set `params` with `a_params`
		do
			params := a_params
		ensure
			params_set: params = a_params
		end

	set_id (a_val: like id)
			-- Set `id` with `a_val`.
		do
			id := a_val
		ensure
			id_set: id = a_val
		end
feature -- Status Report

	is_valid: BOOLEAN
			-- Does this RCP request object is valid?
		do
			Result := attached jsonrpc as l_jsonrcp and then l_jsonrcp.same_string_general ("2.0") and then
					attached method and then attached id
		end
end
