note
	description: "Summary description for {JSON_RPC_RESPONSE_SERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_RESPONSE_SERIALIZER

inherit
	JSON_SERIALIZER

	JSON_RPC_RESPONSE_NAMES
		export
			{NONE} all
		end

feature -- Convertion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
			-- JSON value representing the JSON serialization of Eiffel value `obj', in the eventual context `ctx'.	
		local
			jo: JSON_OBJECT
		do
			if attached {JSON_RPC_RESPONSE} obj as o then
				create jo.make
				if attached o.jsonrpc as l_jsonrcp then
					jo.put_string (l_jsonrcp, jsonrpc_key)
				end
				if attached o.jresult as l_result then
					jo.put (to_json_value (l_result), result_key)
				end
				if attached o.error as l_error then
					jo.put (to_json_error (l_error), error_key)
				end
				if attached o.id as l_id then
					jo.put (to_json_value (l_id.id), id_key)
				else
					jo.put (create {JSON_NULL}, id_key)
				end
				Result := jo
			else
				create {JSON_NULL} Result
			end
		end


feature -- Convert JSON_RCP_ID

	to_json_value (a_obj: detachable ANY): JSON_VALUE
			-- Convert an object `a_obj' to JSON_VALUE representation.
		local
			obj: ANY
			conv_to: JSON_REFLECTOR_SERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT
		do
			obj := a_obj

				-- Auto serialization, handling table iterable as JSON Object, and iterable as ARRAY. Without typename.
			create conv_to
			create ctx
			ctx.set_pretty_printing
			ctx.set_is_type_name_included (False)
			ctx.set_default_serializer (create {JSON_REFLECTOR_SERIALIZER})
			ctx.register_serializer (create {TABLE_ITERABLE_JSON_SERIALIZER [detachable ANY, READABLE_STRING_GENERAL]}, {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]})
			ctx.register_serializer (create {ITERABLE_JSON_SERIALIZER [detachable ANY]}, {ITERABLE [detachable ANY]})

			Result := conv_to.to_json (obj, ctx)
		end

	to_json_error (a_error: JSON_RPC_ERROR): JSON_VALUE
		local
			jo: JSON_OBJECT
		do
			create jo.make
			jo.put_integer (a_error.code, code_key)
			jo.put_string (a_error.message, message_key)
			if attached a_error.data as l_data then
				jo.put_string (l_data, data_key)
			end
			Result := jo
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
