note
	description: "[
		JSON_RPC_RESPONSE_CONVERTER  allow to go `from_json' and return a  object and `to_json' convert an object JSON_RCP_RESPONSE into a JSON 
		representation
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_RESPONSE_CONVERTER

feature -- Access

	from_json (j: JSON_VALUE): detachable JSON_RPC_RESPONSE
			-- Convert from JSON value. Returns Void if unable to convert
		local
			ctx: JSON_DESERIALIZER_CONTEXT
		do
			create ctx
			Result := (create {JSON_RPC_RESPONSE_DESERIALIZER}).from_json (j, ctx, Void)
		end

	to_json (o: JSON_RPC_RESPONSE): JSON_VALUE
			-- Convert to JSON value
		local
			ctx: JSON_SERIALIZER_CONTEXT
		do
			create ctx
			Result := (create {JSON_RPC_RESPONSE_SERIALIZER}).to_json (o, ctx)
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
