# frozen_string_literal: true

require 'vcr'
require 'webmock'
WebMock.enable!

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
end

RSpec.configure do |config|
  # Add VCR to all tests
  config.around(:each) do |example|
    vcr_tag = example.metadata[:vcr]

    if vcr_tag == false
      VCR.turned_off(&example)
    else
      options = vcr_tag.is_a?(Hash) ? options : {}
      path_data = [example.metadata[:description]]
      parent = example.example_group
      while parent != RSpec::ExampleGroups
        path_data << parent.metadata[:description]
        parent = parent.parent
      end

      name = path_data.map{|str| str.underscore.gsub(/\./,'').gsub(/[^\w\/]+/, '_').gsub(/\/$/, '')}.reverse.join("/")

      VCR.use_cassette(name, options, &example)
    end
  end
end
