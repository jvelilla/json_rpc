note
	description: "[
		Object Representing JSON RPC Parameters by names
		
		Parameter Structures
		If present, parameters for the RPC call MUST be provided as a structured value.
		params MUST be an Object, with member names that match the Server expected parameter names. 
		The absence of expected names MAY result in an error being generated. 
		The names MUST match exactly, including case, to the method's expected parameters.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_NAMED_PARAMS

inherit
	JSON_RPC_PARAMS

create
	make_empty,
	make

feature {NONE} -- Initialization

	make_empty
		do
			make (0)
		end

	make (nb: INTEGER)
			-- Create a object with params by name
		do
			create items.make (nb)
		end

feature -- Access

	has (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Has value associated with name `a_name` ?
		do
			Result := items.has (a_name)
		end

	item alias "[]" (a_name: READABLE_STRING_GENERAL): ANY assign put
		require
			has: has (a_name)
		do
			Result := items.definite_item (a_name)
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [ANY]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Change Element

	put (a_value: ANY; a_name: READABLE_STRING_GENERAL)
			-- Add a parameter with name `a_name` and value `a_value`.
		do
			items.force (a_value, a_name)
		end

	append (a_table: TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL])
			-- -- Append to `items` table with a `a_table`.
		do
			across a_table as ic loop
				if attached ic.item as l_item then
					put (l_item, ic.key)
				end
			end
		end

feature -- Access

	items: STRING_TABLE [ANY]
			-- Object, with member names that match the Server expected parameter names.		

;note
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
