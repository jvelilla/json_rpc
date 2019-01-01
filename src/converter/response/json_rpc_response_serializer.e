note
	description: "Summary description for {JSON_RPC_RESPONSE_SERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_RESPONSE_SERIALIZER

inherit

	JSON_SERIALIZER


feature -- Convertion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
			-- JSON value representing the JSON serialization of Eiffel value `obj', in the eventual context `ctx'.	
		local
			jo: JSON_OBJECT
		do
			if attached {JSON_RPC_RESPONSE} obj as o then
				create jo.make
				if attached o.jsonrpc as l_jsonrcp then
					jo.put_string (l_jsonrcp, jsonrcp_key)
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
			if attached  a_error.data as l_data then
				jo.put_string (l_data, data_key)
			end
			Result := jo
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

feature {NONE} -- Implementation JSON RPC RESPONSE

	jsonrcp_key: STRING
		do
			create Result.make_from_string ("jsonrcp")
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
