require "zeal/version"

module Zeal
  class EagerLoadError < RuntimeError; end

  class << self
    if Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR >= 1
      def eager_load(collection, *args)
        if collection.length > 0
          ActiveRecord::Associations::Preloader.new(collection, args).run
        end
        collection
      end
    else
      def eager_load(collection, *args)
        if collection.length > 0
          class_of_collection(collection).send(:preload_associations, collection, args)
        end
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
  end
end
