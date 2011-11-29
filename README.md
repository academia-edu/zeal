Zeal: eager loading (but not too eager) for ActiveRecord collections
====================================================================

Sometimes you need to eager load some associations, but it's not
convenient to do so at the same time as loading the original records.
Zeal is a simple gem that offers a couple of different ways to trigger
ActiveRecord's built in eager loading on an array of already-retrieved
records.

### For Example

Let's say you want to do the equivalent of this:

``` ruby
User.find(:all, :limit => 10, :include => {:posts => :comments})
```

If you're reducing code duplication by loading Users in a before filter
that's shared between multiple actions, it may not make sense to eager
load the same associations for all of those pages. Instead, you can do
this:

``` ruby
# before_filters.rb
@users = User.find(:all, :limit => 10)

# users_controller.rb
def users_and_posts_and_stuff
  @users.eager_load(:posts => :comments)
end

def users_and_friends_and_stuff
  @users.eager_load(:friends, :countrymen)
end
```

You can now avoid N+1 while also avoiding unnecessary preloading and
keeping your code as DRY as possible.

### Usage

There are two ways to use Zeal: the nicer, more intrusive way, and the
more explicit, less intrusive way.

``` ruby
# more_instrusive.rb
class Array
  include Zeal::ArrayMethods
end

@users.eager_load(:friends, :countrymen)

# less_intrusive.rb
Zeal.eager_load(@users, [:friends, :countrymen])
```

Your choice!
