require "zeal/version"

module Zeal
  class EagerLoadError < RuntimeError; end

  class << self
    if Rails.version.to_s =~ /^3/
      def eager_load(collection, *args)
        ActiveRecord::Associations::Preloader.new(collection, args).run
        collection
      end
    else
      def eager_load(collection, *args)
        class_of_collection(collection).send(:preload_associations, collection, args)
        collection
      end
    end

    private
    def class_of_collection(collection)
      klasses = collection.map(&:class).uniq
      if klasses.count > 1
        raise EagerLoadError, "Collection includes objects of multiple classes: #{klasses.inspect}"
      end

      klass = klasses.first
      unless klass < ActiveRecord::Base
        raise EagerLoadError, "#{klass} isn't an ActiveRecord class."
      end

      klass
    end
  end

  def eager_load(*args)
    Zeal.eager_load(self, *args)
    self
  end
end
