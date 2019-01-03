note
	description: "Summary description for {JSON_RPC_RESPONSE_DESERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_RESPONSE_DESERIALIZER

inherit
	JSON_DESERIALIZER

	JSON_RPC_RESPONSE_NAMES
		export
			{NONE} all
		end

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable JSON_RPC_RESPONSE
			-- Eiffel value deserialized from `a_json' value, in the eventual context `ctx'.
		local
			js: JSON_STRING
			l_table: STRING_TABLE [detachable ANY]
			l_array: ARRAY [detachable ANY]
		do
			if attached {JSON_OBJECT} a_json as j then
				create Result

					-- jsonrpc
				if attached {JSON_STRING} j.string_item (jsonrpc_key) as l_jsonrpc then
					Result.set_jsonrpc (l_jsonrpc.unescaped_string_8)
				end

					-- result
				if attached {JSON_VALUE} j.item (result_key) as l_result then
					Result.set_result (from_rpc_result (l_result))
				end

					-- error
				if attached {JSON_OBJECT} j.object_item (error_key) as l_error then
					Result.set_error (from_json_rpc_error (l_error))
				end
					-- id
				if attached j.item (id_key) as l_object then
					Result.set_id (from_json_rpc_id (l_object))
				end
			end
		end

feature -- From JSON

	from_json_rpc_id (a_object: JSON_VALUE): detachable JSON_RPC_ID
		do
			if attached {JSON_STRING} a_object as l_str then
				create Result
				Result.set_id (l_str.unescaped_string_8)
			elseif attached {JSON_NULL} a_object as l_null then
				create Result
			elseif attached {JSON_NUMBER} a_object as l_number then
				create Result
				if l_number.is_integer then
					Result.set_id (l_number.integer_64_item)
				elseif l_number.is_double then
					Result.set_id (l_number.real_64_item)
				else -- natural	
					Result.set_id (l_number.natural_64_item)
				end
			end
		end

	from_json_rpc_error (a_object: JSON_OBJECT): detachable JSON_RPC_ERROR
		do
			if
				attached {JSON_NUMBER} a_object.item (code_key) as l_number and then
				l_number.is_integer and then attached {JSON_STRING} a_object.item (message_key) as l_message
			then
				create Result.make (l_number.integer_64_item.to_integer_32, l_message.unescaped_string_8)

				if attached {JSON_STRING} a_object.item (data_key) as l_data then
					Result.set_data (l_data.unescaped_string_8)
				end
			end
		end

	from_rpc_result (a_result: JSON_VALUE): detachable ANY
		local
			l_conv: JSON_BASIC_SERIALIZATION
		do
			create l_conv.make
			Result := l_conv.from_json (a_result)
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
