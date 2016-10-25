require 'spec_helper'

describe Resque::Job do

  it 'should recognize its own class' do
    Resque::Job.new("pepito", "fasjlfd").should be_a Resque::Job
  end

end