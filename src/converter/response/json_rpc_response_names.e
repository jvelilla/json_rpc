note
	description: "Summary description for {JSON_RPC_RESPONSE_NAMES}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_RESPONSE_NAMES

feature -- JSON names for JSON_RPC_ERROR

	code_key: JSON_STRING
		do
			Result := "code"
		ensure
			instance_free: class
		end

	message_key: JSON_STRING
		do
			Result := "message"
		ensure
			instance_free: class
		end

	data_key: JSON_STRING
		do
			Result := "data"
		ensure
			instance_free: class
		end

feature -- JSON names for JSON RPC RESPONSE

	jsonrpc_key: JSON_STRING
		do
			Result := "jsonrpc"
		ensure
			instance_free: class
		end

	result_key: JSON_STRING
		do
			Result := "result"
		ensure
			instance_free: class
		end

	error_key: JSON_STRING
		do
			Result := "error"
		ensure
			instance_free: class
		end

	id_key: JSON_STRING
		do
			Result := "id"
		ensure
			instance_free: class
		end

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
