class Hash
	
	def deep_merge!(specialized_hash)
		return internal_deep_merge!(self, specialized_hash)
	end
	
	
	def deep_merge(specialized_hash)
		return internal_deep_merge!(Hash.new.replace(self), specialized_hash)
	end
	
	
	protected
		
		# better, recursive, preserving method
		# OK OK this is not the most efficient algorithm,
		# but at last it's *perfectly clear and understandable*
		# so fork and improve if you need 5% more speed, ok ?
		def internal_deep_merge!(source_hash, specialized_hash)
			
			#puts "starting deep merge..."
			
			specialized_hash.each_pair do |rkey, rval|
				#puts "   potential replacing entry : " + rkey.inspect
				
				if source_hash.has_key?(rkey) then
					#puts "   found potentially conflicting entry for #{rkey.inspect} : #{rval.inspect}, will merge :"
					if rval.is_a?(Hash) and source_hash[rkey].is_a?(Hash) then
						#puts "      recursing..."
						internal_deep_merge!(source_hash[rkey], rval)
					elsif rval == source_hash[rkey] then
						#puts "      same value, skipping."
					else
						#puts "      replacing."
						source_hash[rkey] = rval
					end
				else
					#puts "   found new entry #{rkey.inspect}, adding it..."
					source_hash[rkey] = rval
				end
			end
			
			#puts "deep merge done."
			
			return source_hash
		end
end
