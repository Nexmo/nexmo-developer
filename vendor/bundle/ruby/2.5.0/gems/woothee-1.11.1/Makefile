all: test

testsets:
	git submodule update --init

lib/woothee/dataset.rb: testsets
	ruby scripts/dataset_yaml2rb.rb
	sync; sync; sync

test: lib/woothee/dataset.rb
	bundle exec rspec spec
