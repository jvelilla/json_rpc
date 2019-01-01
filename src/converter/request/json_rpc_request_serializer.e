note
	description: "Summary description for {JSON_RPC_REQUEST_SERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_REQUEST_SERIALIZER

inherit

	JSON_SERIALIZER


feature -- Convertion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
			-- JSON value representing the JSON serialization of Eiffel value `obj', in the eventual context `ctx'.	
		local
			jo: JSON_OBJECT
		do
			if attached {JSON_RPC_REQUEST} obj as o then
				create jo.make
				if attached o.jsonrpc as l_jsonrcp then
					jo.put_string (l_jsonrcp, jsonrpc_key)
				end
				if attached o.method as l_method then
					jo.put_string (l_method, method_key)
				end
				if attached o.id as l_id then
					jo.put (to_json_value (l_id.id), id_key)
				else
					jo.put (create {JSON_NULL}, id_key)
				end

				if attached o.params as l_params then
					if l_params.is_by_position then
						jo.put (to_json_value (l_params.by_position), params_key)
					else
						jo.put (to_json_value (l_params.by_name), params_key)
					end
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

feature {NONE} -- Implementation

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
