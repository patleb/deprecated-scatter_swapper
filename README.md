# ScatterSwapper

### Installation

Add to your Gemfile:

```ruby
gem 'scatter_swapper'
```

Now, everytime an URL has a parameter with a name like `id` or `any_name_id`, it will be automatically converted to the decoded id.
So, no need to change your controller code when accessing resources.

Although, **URL generation isn't modified**... yet (still not sure if overriding `to_param` is the best solution), so you will need to pass the encoded id which is available through your model by the method `encoded_id`.

### [Scatter Swap](https://github.com/altabyte/scatter_swap)

Since `scatter_swap` isn't maintained anymore, the code has been brought back into this gem.


This project rocks and uses MIT-LICENSE.
