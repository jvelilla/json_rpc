note
	description: "[
		Represent a JSON RPC ID used in Request or Response
		
		Request
		 	An identifier established by the Client that MUST contain a String, Number, or NULL value if included.
		 	If it is not included it is assumed to be a notification. The value SHOULD normally not be Null [1] and Numbers SHOULD NOT contain fractional parts [2]
			The Server MUST reply with the same value in the Response object if included. This member is used to correlate the context between the two objects.
			[1] The use of Null as a value for the id member in a Request object is discouraged, because this specification uses a value of Null for Responses with an unknown id.
			Also, because JSON-RPC 1.0 uses an id value of Null for Notifications this could cause confusion in handling.
			[2] Fractional parts may be problematic, since many decimal fractions cannot be represented exactly as binary fractions.

		
		Response
			This member is REQUIRED.
			It MUST be the same as the value of the id member in the Request Object.
			If there was an error in detecting the id in the Request object (e.g. Parse error/Invalid Request), it MUST be Null.

		]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_ID

feature -- Access

	id: detachable ANY
			-- value of the id, String, Number or Null.

	is_valid (a_id: detachable ANY): BOOLEAN
			-- Is a valid id.
		do
			if attached a_id as l_id then
				if attached {STRING_32} l_id then
					Result := True
				elseif attached {STRING_8} l_id  then
					Result := True
				elseif attached {NATURAL_8} l_id  then
					Result := True
				elseif attached {NATURAL_16} l_id then
					Result := True
				elseif attached {NATURAL_32} l_id then
					Result := True
				elseif attached {NATURAL_64} l_id then
					Result := True
				elseif attached {INTEGER_8} l_id  then
					Result := True
				elseif attached {INTEGER_16} l_id then
					Result := True
				elseif attached {INTEGER_32} l_id then
					Result := True
				elseif attached {INTEGER_64} l_id then
					Result := True
				elseif attached {REAL_32} l_id then
					Result := True
				elseif attached {REAL_64} l_id then
					Result := True
				end
			else
					-- Void is a value
					-- Null.
				Result := True
			end
		end


feature -- Change Element

	set_id (a_id: like id)
			-- Set `id` with `a_id`.
		require
			is_valid:  is_valid (a_id)
		do
			id := a_id
		ensure
			id_set: id = a_id
		end


invariant
	valid_id: is_valid (id)

end
