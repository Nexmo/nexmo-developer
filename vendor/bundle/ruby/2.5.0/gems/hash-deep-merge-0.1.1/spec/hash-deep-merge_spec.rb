require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "HashDeepMerge" do
	
	
	######################################################################
	describe "handling of ordinary hashes" do
		
		before(:each) do
			# When hashes don't contain other hashes, deep_merge works the same as merge.
			@hash1 = { 3 => 2,    :test => 1, 'toto' => 'titi', :foo => :bar }
			@hash2 = { 3 => '42', :test => 2, 'toto' => 'titi',               :fooz => :barz }
			
			# Expected results, computed manually.
			@expected_result_1to2 = { 3 => '42', :test => 2, 'toto' => 'titi', :foo  => :bar,  :fooz => :barz }
			@expected_result_2to1 = { 3 => 2,    :test => 1, 'toto' => 'titi', :fooz => :barz, :foo  => :bar }
			
			# We store copie to check for modifications,
			# because some functions are expected to change the values and some not.
			@hash1_copy = Hash.new.replace(@hash1)
			@hash2_copy = Hash.new.replace(@hash2)
			
			# This is not really a test, it's just to remember prerequisites for following tests.
			# (If we want to test no modifications, we just have to merge a hash with itself)
			@expected_result_1to2.should_not == @hash1
			@expected_result_1to2.should_not == @hash2
			@expected_result_2to1.should_not == @hash1
			@expected_result_2to1.should_not == @hash2
		end
		
		######################## MERGE ########################
		describe "merge function" do
			it "should behave the same (exact identity case)" do
				
				expected_result = @hash1_copy
				
				# first we do it with the ordinary "merge" function, to check.
				result = @hash1.merge(@hash1) # merge to itself
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
				
				# Now we do it with deep_merge
				result = @hash1.deep_merge(@hash1)
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
			end
			
			it "should behave the same (shuffled identity case)" do
				# really needed ?
				pending
			end
			
			it "should behave the same (different case)" do
				expected_result = @expected_result_1to2
				
				# first we do it with the ordinary "merge" function, to check.
				result = @hash1.merge(@hash2)
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
				
				# Now we do it with deep_merge
				result = @hash1.deep_merge(@hash2)
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
			end
			
			it "should behave the same (different case reversed)" do
				expected_result = @expected_result_2to1
				
				# first we do it with the ordinary "merge" function, to check.
				result = @hash2.merge(@hash1)
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
				
				# Now we do it with deep_merge
				result = @hash2.deep_merge(@hash1)
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
			end
		end # merge
		
		######################## MERGE!!! ########################
		describe "merge!" do
			it "should behave the same (exact identity case)" do
				
				expected_result = @hash1_copy
				
				# first we do it with the ordinary "merge" function, to check.
				@hash1.merge!(@hash1) # merge to itself
				result = @hash1
				@hash1.should == @hash1_copy # should be equal
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
				
				# restore @hash1
				@hash1 = Hash.new.replace(@hash1_copy)
				@hash1.should == @hash1_copy # should have been restored
				
				# Now we do it with deep_merge
				@hash1.deep_merge!(@hash1)
				result = @hash1
				@hash1.should == @hash1_copy # should be equal
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
			end
			
			it "should behave the same (shuffled identity case)" do
				# really needed ?
				pending
			end
			
			it "should behave the same (different case)" do
				expected_result = @expected_result_1to2
				
				# first we do it with the ordinary "merge!" function, to check.
				@hash1.merge!(@hash2) # XXX with ! XXX
				result = @hash1
				@hash1.should_not == @hash1_copy # *should* have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
				
				# restore @hash1
				@hash1 = Hash.new.replace(@hash1_copy)
				@hash1.should == @hash1_copy # should have been restored
				
				# Now we do it with deep_merge
				result = @hash1.deep_merge!(@hash2) # XXX with ! XXX
				@hash1.should_not == @hash1_copy # *should* have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
			end
			
			it "should behave the same (different case reversed)" do
				expected_result = @expected_result_2to1
				
				# first we do it with the ordinary "merge!" function, to check.
				@hash2.merge!(@hash1)
				result = @hash2
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should_not == @hash2_copy # *should* have been modified
				result.should == expected_result
				
				# restore @hash2
				@hash2 = Hash.new.replace(@hash2_copy)
				@hash2.should == @hash2_copy # should not have been modified
				
				# Now we do it with deep_merge
				@hash2.deep_merge!(@hash1)
				result = @hash2
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should_not == @hash2_copy # *should* have been modified
				result.should == expected_result
			end
		end # merge!
	end # handling of ordinary hashes
	
	
	
	######################################################################
	describe "handling of hashes containing hashes" do
		
		before(:each) do
			# same as before, but with sub hashes
			@hash1 = { 3 => 2,    :test => 1, 'toto' => 'titi', :foo => :bar,
			           'sub hash 1' => {
			                   3 => 2,    :test => 1, 'toto' => 'titi', :foo => :bar },
			           'sub hash 2' => {
			                   'hello' => 'world' },
			          }
			@hash2 = { 3 => '42', :test => 2, 'toto' => 'titi',               :fooz => :barz,
			           'sub hash 1' => {
			                   3 => '42', :test => 2, 'toto' => 'titi',               :fooz => :barz },
			           'sub hash 3' => {
			                   'hello' => 'world' },
			          }
			
			# Expected results, computed manually.
			@expected_result_1to2 = { 3            => '42',
			                          :test        => 2,
			                          'toto'       => 'titi',
			                          :foo         => :bar,
			                          'sub hash 1' => {
			                                     3 => '42', :test => 2, 'toto' => 'titi', :foo => :bar, :fooz => :barz},
			                          'sub hash 2' => {
			                                     'hello' => 'world' },
			                          'sub hash 3' => {
			                                     'hello' => 'world' },
			                          :fooz        => :barz,
			                         }
			@expected_result_2to1 = { 3            => 2,
			                          :test        => 1,
			                          'toto'       => 'titi',
			                          :fooz        => :barz,
			                          'sub hash 1' => {
			                                     3 => 2, :test => 1, 'toto' => 'titi', :fooz => :barz, :foo => :bar},
			                          'sub hash 3' => {
			                                     'hello' => 'world' },
			                          'sub hash 2' => {
			                                     'hello' => 'world' },
			                          :foo         => :bar,
			                         }
			
			# We store copie to check for modifications,
			# because some functions are expected to change the values and some not.
			@hash1_copy = Hash.new.replace(@hash1)
			@hash2_copy = Hash.new.replace(@hash2)
			
			# This is not really a test, it's just to remember prerequisites for following tests.
			# (If we want to test no modifications, we just have to merge a hash with itself)
			@expected_result_1to2.should_not == @hash1
			@expected_result_1to2.should_not == @hash2
			@expected_result_2to1.should_not == @hash1
			@expected_result_2to1.should_not == @hash2
		end
		
		######################## MERGE ########################
		describe "merge" do
			
			it "should work (exact identity case)" do
				
				expected_result = @hash1_copy
				result = @hash1.deep_merge(@hash1)
				
				@hash1.should == @hash1_copy # should be equal
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
			end
			
			it "should work (shuffled identity case)" do
				# really needed ?
				pending
			end
			
			it "should work (different case)" do
			
				expected_result = @expected_result_1to2
				result = @hash1.deep_merge(@hash2)
				
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
				result['sub hash 1'].should have(expected_result['sub hash 1'].length).entries
				result['sub hash 1'].should ==   expected_result['sub hash 1']
				result['sub hash 2'].should have(expected_result['sub hash 2'].length).entries
				result['sub hash 2'].should ==   expected_result['sub hash 2']
				result['sub hash 3'].should have(expected_result['sub hash 3'].length).entries
				result['sub hash 3'].should ==   expected_result['sub hash 3']
			end
			
			it "should work (different case reversed)" do
			
				expected_result = @expected_result_2to1
				result = @hash2.deep_merge(@hash1)
				
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
				result['sub hash 1'].should have(expected_result['sub hash 1'].length).entries
				result['sub hash 1'].should ==   expected_result['sub hash 1']
				result['sub hash 2'].should have(expected_result['sub hash 2'].length).entries
				result['sub hash 2'].should ==   expected_result['sub hash 2']
				result['sub hash 3'].should have(expected_result['sub hash 3'].length).entries
				result['sub hash 3'].should ==   expected_result['sub hash 3']
			end
			
		end # merge
		
		######################## MERGE!!! ########################
		describe "merge!" do
			
			it "should work (exact identity case)" do
				
				expected_result = @hash1_copy
				@hash1.deep_merge!(@hash1)
				result = @hash1
				
				@hash1.should == @hash1_copy # should be equal
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
			end
			
			it "should work (shuffled identity case)" do
				# really needed ?
				pending
			end
			
			it "should work (different case)" do
			
				expected_result = @expected_result_1to2
				@hash1.deep_merge!(@hash2)
				result = @hash1
				
				@hash1.should_not == @hash1_copy # *should* have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
				result['sub hash 1'].should have(expected_result['sub hash 1'].length).entries
				result['sub hash 1'].should ==   expected_result['sub hash 1']
				result['sub hash 2'].should have(expected_result['sub hash 2'].length).entries
				result['sub hash 2'].should ==   expected_result['sub hash 2']
				result['sub hash 3'].should have(expected_result['sub hash 3'].length).entries
				result['sub hash 3'].should ==   expected_result['sub hash 3']
			end
			
			it "should work (different case reversed)" do
			
				expected_result = @expected_result_2to1
				@hash2.deep_merge!(@hash1)
				result = @hash2
				
				@hash1.should == @hash1_copy # should not have been modified
				@hash2.should_not == @hash2_copy # *should* have been modified
				result.should == expected_result
				result['sub hash 1'].should have(expected_result['sub hash 1'].length).entries
				result['sub hash 1'].should ==   expected_result['sub hash 1']
				result['sub hash 2'].should have(expected_result['sub hash 2'].length).entries
				result['sub hash 2'].should ==   expected_result['sub hash 2']
				result['sub hash 3'].should have(expected_result['sub hash 3'].length).entries
				result['sub hash 3'].should ==   expected_result['sub hash 3']
			end
			
		end # merge
	end # hash with sub hashes
	
	######################################################################
	describe "handling of hashes containing hashes containing hashes" do
		before(:each) do
			# same as before, but with sub sub hashes
			# things start to get complicated, isn't it ?
			@hash1 = {
				3            => 2,
				:test        => 1,
				'toto'       => 'titi',
				:foo         => :bar,
				'sub hash 1' => {
					3                => 2,
					:test            => 1,
					'toto'           => 'titi',
					:foo             => :bar,
					'sub sub hash 1' => {
						3      => '42',
						:test  => 2,
						'toto' => 'titi',
						:fooz  => :barz
					},
				},
				'sub hash 2' => {
					'hello' => 'world'
				},
			}
			@hash2 = {
				3            => '42',
				:test        => 2,
				'toto'       => 'titi',
				:fooz        => :barz,
				'sub hash 1' => {
					3                => '42',
					:test            => 2,
					'toto'           => 'titi',
					:fooz            => :barz,
					'sub sub hash 1' => {
						3      => 2,
						:test  => 1,
						'toto' => 'titi',
						:foo   => :bar
					},
				},
				'sub hash 2' => {
					'hello' => 'worldy'
				},
			}
			
			# Expected results, computed manually.
			@expected_result_1to2 = {
				3            => '42',
				:test        => 2,
				'toto'       => 'titi',
				:foo         => :bar,
				'sub hash 1' => {
					3                => '42',
					:test            => 2,
					'toto'           => 'titi',
					:foo             => :bar,
					'sub sub hash 1' => {
						3      => 2,
						:test  => 1,
						'toto' => 'titi',
						:fooz  => :barz,
						:foo   => :bar
					},
					:fooz => :barz
				},
				'sub hash 2' => {
					'hello' => 'worldy'
				},
				:fooz        => :barz,
			}
			
			# Gaaah ! My head burns !
			
			# We store copie to check for modifications,
			# because some functions are expected to change the values and some not.
			@hash1_copy = Hash.new.replace(@hash1)
			@hash2_copy = Hash.new.replace(@hash2)
			
			# This is not really a test, it's just to remember prerequisites for following tests.
			# (If we want to test no modifications, we just have to merge a hash with itself)
			@expected_result_1to2.should_not == @hash1
			@expected_result_1to2.should_not == @hash2
		end
		
		######################## MERGE ########################
		describe "merge" do
			
			it "should work (exact identity case)" do
			
				expected_result = @hash1_copy
				@hash1.deep_merge!(@hash1)
				result = @hash1
				
				@hash1.should == @hash1_copy # should be equal
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
			end
			
			it "should work (shuffled identity case)" do
				# really needed ?
				pending
			end
			
			it "should work (different case)" do
			
				expected_result = @expected_result_1to2
				@hash1.deep_merge!(@hash2)
				result = @hash1
				
				@hash1.should_not == @hash1_copy # *should* have been modified
				@hash2.should == @hash2_copy # should not have been modified
				result.should == expected_result
				result['sub hash 1'].should ==   expected_result['sub hash 1']
				result['sub hash 1']['sub sub hash 1'].should ==   expected_result['sub hash 1']['sub sub hash 1']
				result['sub hash 2'].should ==   expected_result['sub hash 2']
			end
		end # merge
	end
	
	######################################################################
	describe "handling of hashes containing hashes containing hashes containing hashes" do
		# herm... maybe we'll stop here ;-)
		# I'm mad enough already...
	end
	
end # describe "HashDeepMerge"
