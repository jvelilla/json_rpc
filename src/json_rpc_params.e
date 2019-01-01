note
	description: "[
		Object Representing JSON RPc Parameters
		
		Parameter Structures
		If present, parameters for the rpc call MUST be provided as a Structured value. Either by-position through an Array or by-name through an Object.

		by-position: params MUST be an Array, containing the values in the Server expected order.
		by-name: params MUST be an Object, with member names that match the Server expected parameter names. The absence of expected names MAY result in an error being generated. The names MUST match exactly, including case, to the method's expected parameters.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_PARAMS

create
	make_by_position,
	make_by_name

feature {NONE} -- Initialization

	make_by_name
			-- Create a object with params by name
		do
			create by_name.make (2)
		end

	make_by_position
			-- Create a object with params by position
		do
			create {ARRAYED_LIST [ANY]} by_position.make (2)
		end

feature -- Status Report

	is_by_name: BOOLEAN
			-- 	Are parameters by name expected?
		do
			Result := attached by_name
		end

	is_by_position: BOOLEAN
		do
			Result := attached by_position
		end

feature -- Change Element

	add_by_name (a_name: READABLE_STRING_GENERAL; a_value: ANY)
			-- Add a parameter with name `name` and value `value`.
		require
			is_by_name: is_by_name
		do
			if attached by_name as l_by_name then
				l_by_name.force (a_value, a_name)
			else
				-- Internal error
			end
		end

	add_by_position (a_value: ANY)
			-- Add a parameter with value `value`.
		require
			is_by_position: is_by_position
		do
			if attached by_position as l_by_position then
				l_by_position.force (a_value)
			else
				-- Internal error
			end
		end


	append_list (a_list: like by_position)
			-- Append to `by_position` list with a `a_list`.
		require
			is_by_position: is_by_position
		do
			if
				attached by_position as l_position and then
				attached a_list as l_list
			then
				across l_list as ic loop
					if attached ic.item as l_item then
						add_by_position (l_item)
					end
				end
			end
		end

	append_table (a_table: like by_name)
			-- -- Append to `by_name` table with a `a_table`.
		require
			is_by_name: is_by_name
		do
			if
				attached by_name as l_by_name and then
				attached a_table as l_table
			then
				across l_table as ic loop
					if attached ic.item as l_item then
						add_by_name (ic.key, l_item)
					end
				end
			end
		end

feature -- Access

	by_position: detachable LIST [detachable ANY]
			-- Array, containing the values in the Server expected order.

	by_name:  detachable STRING_TABLE [detachable ANY]
			-- Object, with member names that match the Server expected parameter names.		

invariant
		by_position_set: attached by_position implies by_name = Void
		by_name_set: attached by_name implies by_position = Void
end
