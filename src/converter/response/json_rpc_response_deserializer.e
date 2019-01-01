note
	description: "Summary description for {JSON_RPC_RESPONSE_DESERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_RESPONSE_DESERIALIZER

inherit

	JSON_DESERIALIZER


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


feature {NONE} -- Implementation JSON_RPC_ERROR

	code_key: STRING
		do
			create Result.make_from_string ("code")
		ensure
			instance_free: class
		end

	message_key: STRING
		do
			create Result.make_from_string ("message")
		ensure
			instance_free: class
		end

	data_key: STRING
		do
			create Result.make_from_string ("data")
		ensure
			instance_free: class
		end


feature {NONE} -- Implementation JSON_RPC_RESPONSE

	jsonrpc_key: STRING
		do
			create Result.make_from_string ("jsonrpc")
		ensure
			instance_free: class
		end

	result_key: STRING
		do
			create Result.make_from_string ("result")
		ensure
			instance_free: class
		end

	error_key: STRING
		do
			create Result.make_from_string ("error")
		ensure
			instance_free: class
		end

	id_key: STRING
		do
			create Result.make_from_string ("id")
		ensure
			instance_free: class
		end

end
