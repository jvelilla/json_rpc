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
			if a_id /= Void then
				if attached {READABLE_STRING_GENERAL} a_id then
					Result := True
				elseif attached {NUMERIC} a_id then
					Result := True
				else
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
			is_valid: is_valid (a_id)
		do
			id := a_id
		ensure
			id_set: id = a_id
		end


invariant
	valid_id: is_valid (id)

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
