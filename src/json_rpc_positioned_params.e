note
	description: "[
		Object Representing JSON RPC Parameters by position
		
		Parameter Structures
		If present, parameters for the RPC call MUST be provided as a structured value. 
		params MUST be an Array, containing the values in the Server expected order.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_POSITIONED_PARAMS

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
			-- Create a object with params by position
		do
			create items.make (nb)
		end

feature -- Access

	has (a_index: INTEGER): BOOLEAN
			-- Has value at position `a_index` ?
		do
			Result := a_index >= 1 and a_index <= items.count
		end

	item alias "[]" (a_index: INTEGER): ANY
		require
			has: has (a_index)
		do
			Result := items.i_th (a_index)
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [ANY]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Change Element

	extend (a_value: ANY)
			-- Add a parameter with value `value`.
		do
			items.force (a_value)
		end

	append (a_list: ITERABLE [detachable ANY])
			-- Append to `items` list with a `a_list`.
		do
			across a_list as ic loop
				if attached ic.item as l_item then
					extend (l_item)
				end
			end
		end

feature -- Access

	items: ARRAYED_LIST [ANY]
			-- Array, containing the values in the Server expected order.

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
