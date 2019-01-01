note
	description: "Summary description for {JSON_RPC_REQUEST_DESERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_REQUEST_DESERIALIZER

inherit
	JSON_DESERIALIZER


feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable JSON_RPC_REQUEST
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

					-- method
				if attached {JSON_STRING} j.string_item (method_key) as l_method then
					Result.set_method (l_method.unescaped_string_32)
				end

					-- params
				if attached {JSON_OBJECT} j.object_item (params_key) as l_object then
					Result.set_params (from_json_rcp_params_by_name (l_object))
				elseif attached {JSON_ARRAY} j.array_item (params_key) as l_object  then
					Result.set_params (from_json_rcp_params_by_posistion (l_object))
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

	from_json_rcp_params_by_name (a_object: JSON_OBJECT): detachable JSON_RPC_PARAMS
		local
			l_conv: JSON_BASIC_SERIALIZATION
		do
			create l_conv.make
			if attached {STRING_TABLE [detachable ANY]} l_conv.from_json (a_object) as l_table then
				create Result.make_by_name
				Result.append_table (l_table)
			end
		end

	from_json_rcp_params_by_posistion (a_object: JSON_ARRAY): detachable JSON_RPC_PARAMS
		local
			l_conv: JSON_BASIC_SERIALIZATION
		do
			create l_conv.make
			if attached {ARRAYED_LIST [detachable ANY]} l_conv.from_json (a_object) as l_list then
				create Result.make_by_position
				Result.append_list (l_list)
			end
		end

feature {NONE} -- Implementation JSON_RPC_REQUEST

	jsonrpc_key: STRING
		do
			create Result.make_from_string ("jsonrpc")
		ensure
			instance_free: class
		end

	method_key: STRING
		do
			create Result.make_from_string ("method")
		ensure
			instance_free: class
		end

	params_key: STRING
		do
			create Result.make_from_string ("params")
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
