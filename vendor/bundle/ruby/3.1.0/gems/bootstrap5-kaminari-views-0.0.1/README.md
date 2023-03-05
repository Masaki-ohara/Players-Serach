# Bootstrap 5 Kaminari Views

Bootstrap 5 compatible styles for [Kaminari](https://github.com/kaminari/kaminari)

# Installation
Add to your Gemfile
```
  gem 'kaminari'
  gem 'bootstrap5-kaminari-views'
```

And run in console

  `bundle install`

# Usage
Render pagination with this gem's theme

`paginate @users, theme: 'bootstrap-5'`

You can add specific pagination and nav classes

```
  paginate @users, theme: 'bootstrap-5',
                   pagination_class: "pagination-sm",
                   nav_class: "d-inline-block"
```

# Credits

[Kaminari](https://github.com/kaminari/kaminari) - Pagination gem

[twitter-bootstrap-kaminari-views](https://github.com/gabetax/twitter-bootstrap-kaminari-views) - Original, non-gemified implementation

[bootstrap-kaminari-views](https://github.com/matenia/bootstrap-kaminari-views) - Bootstrap 2.x and 3.x compatible gem

[bootstrap4-kaminari-views](https://github.com/KamilDzierbicki/bootstrap4-kaminari-views) - Bootstrap 4.0 compatible gem
