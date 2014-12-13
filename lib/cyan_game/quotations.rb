require 'yaml'

module CyanGame
  class Quotations

    def initialize
      f = File.new(File.join(__dir__, '../../data/quotations.yml'))
      @q = YAML.load(f.read)
    end

    def sample
      @q.sample
    end

  end
end
