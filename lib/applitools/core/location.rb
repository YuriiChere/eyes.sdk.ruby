# frozen_string_literal: true

require 'applitools/core/region'
module Applitools
  class Location
    class << self
      def from_any_attribute(*args)
        if args.size == 2
          new args[0], args[1]
        elsif args.size == 1
          value = args.shift
          from_hash(value) if value.is_a? Hash
          from_array(value) if value.is_a? Array
          from_string(value) if value.is_a? String
          from_struct(value) if value.respond_to?(:x) & value.respond_to?(:y)
        end
      end

      alias for from_any_attribute

      def from_hash(value)
        new value[:x], value[:y]
      end

      def from_array(value)
        new value.shift, value.shift
      end

      def from_string(value)
        x, y = value.split(/x/)
        new x, y
      end

      def from_struct(value)
        new value.x, value.y
      end
    end

    attr_reader :x, :y

    alias left x
    alias top y

    def initialize(x, y)
      @x = x
      @y = y
    end

    TOP_LEFT = Location.new(0, 0).freeze

    def to_s
      "#{x} x #{y}"
    end

    def ==(other)
      return super.==(other) unless other.is_a?(Location)
      @x == other.x && @y == other.y
    end

    def !=(other)
      !(self == other)
    end

    alias eql? ==

    def hash
      @x.hash & @y.hash
    end

    def negative_part
      new_x = @x < 0 ? @x : 0
      new_y = @y < 0 ? @y : 0
      self.class.new(new_x.round, new_y.round)
    end

    def positive_part
      new_x = @x < 0 ? 0 : @x
      new_y = @y < 0 ? 0 : @y
      self.class.new(new_x.round, new_y.round)
    end

    def to_hash(options = {})
      options[:region] ? { left: left, top: top } : { x: x, y: y }
    end

    def values
      [x, y]
    end

    def offset(other)
      @x += other.x
      @y += other.y
      self
    end

    def offset_negative(other)
      @x -= other.x
      @y -= other.y
      self
    end

    def scale_it!(scale_factor)
      raise Applitools::EyesIllegalArgument, 'scale_factor must be an integer' unless scale_factor.is_a? Integer
      @x *= scale_factor
      @y *= scale_factor
      self
    end
  end
end
