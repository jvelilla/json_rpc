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

deferred class
	JSON_RPC_PARAMS

inherit
	ITERABLE [ANY]

feature -- Status Report

	is_by_name: BOOLEAN
			-- 	Are parameters by name expected?
		do
			Result := attached {JSON_RPC_NAMED_PARAMS} Current
		end

	by_name: detachable JSON_RPC_NAMED_PARAMS
		do
			if attached {JSON_RPC_NAMED_PARAMS} Current as p then
				Result := p
			end
		end

	is_by_position: BOOLEAN
		do
			Result := attached {JSON_RPC_POSITIONED_PARAMS} Current
		end

	by_position: detachable JSON_RPC_POSITIONED_PARAMS
		do
			if attached {JSON_RPC_POSITIONED_PARAMS} Current as p then
				Result := p
			end
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
