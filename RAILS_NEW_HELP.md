### rails new --help

```shell
Usage:
  rails new APP_PATH [options]

Options:
                 [--skip-namespace]                                            # Skip namespace (affects only isolated engines)
                                                                               # Default: false
                 [--skip-collision-check]                                      # Skip collision check
                                                                               # Default: false
  -r,            [--ruby=PATH]                                                 # Path to the Ruby binary of your choice
                                                                               # Default: /root/.rbenv/versions/3.2.2/bin/ruby
  -n,            [--name=NAME]                                                 # Name of the app
  -m,            [--template=TEMPLATE]                                         # Path to some application template (can be a filesystem path or URL)
  -d,            [--database=DATABASE]                                         # Preconfigure for selected database
                                                                               # Default: sqlite3
                                                                               # Possible values: mysql, trilogy, postgresql, sqlite3, mariadb-mysql, mariadb-trilogy
  -G,            [--skip-git]                                                  # Skip git init, .gitignore and .gitattributes
                 [--skip-docker]                                               # Skip Dockerfile, .dockerignore and bin/docker-entrypoint
                 [--skip-keeps]                                                # Skip source control .keep files
  -M,            [--skip-action-mailer]                                        # Skip Action Mailer files
                 [--skip-action-mailbox]                                       # Skip Action Mailbox gem
                 [--skip-action-text]                                          # Skip Action Text gem
  -O,            [--skip-active-record]                                        # Skip Active Record files
                 [--skip-active-job]                                           # Skip Active Job
                 [--skip-active-storage]                                       # Skip Active Storage files
  -C,            [--skip-action-cable]                                         # Skip Action Cable files
  -A,            [--skip-asset-pipeline]                                       # Indicates when to generate skip asset pipeline
  -J, --skip-js, [--skip-javascript]                                           # Skip JavaScript files
                 [--skip-hotwire]                                              # Skip Hotwire integration
                 [--skip-jbuilder]                                             # Skip jbuilder gem
  -T,            [--skip-test]                                                 # Skip test files
                 [--skip-system-test]                                          # Skip system test files
                 [--skip-bootsnap]                                             # Skip bootsnap gem
                 [--skip-dev-gems]                                             # Skip development gems (e.g., web-console)
                 [--skip-thruster]                                             # Skip Thruster setup
                 [--skip-rubocop]                                              # Skip RuboCop setup
                 [--skip-brakeman]                                             # Skip brakeman setup
                 [--skip-ci]                                                   # Skip GitHub CI files
                 [--skip-kamal]                                                # Skip Kamal setup
                 [--skip-solid]                                                # Skip Solid Cache, Queue, and Cable setup
                 [--dev], [--no-dev], [--skip-dev]                             # Set up the application with Gemfile pointing to your Rails checkout
                 [--devcontainer], [--no-devcontainer], [--skip-devcontainer]  # Generate devcontainer files
                 [--edge], [--no-edge], [--skip-edge]                          # Set up the application with a Gemfile pointing to the 8-0-stable branch on the Rails repository
  --master,      [--main], [--no-main], [--skip-main]                          # Set up the application with Gemfile pointing to Rails repository main branch
                 [--rc=RC]                                                     # Path to file containing extra configuration options for rails command
                 [--no-rc]                                                     # Skip loading of extra configuration options from .railsrc file
                 [--api], [--no-api], [--skip-api]                             # Preconfigure smaller stack for API only apps
                                                                               # Default: false
                 [--minimal], [--no-minimal], [--skip-minimal]                 # Preconfigure a minimal rails app
  -j, --js,      [--javascript=JAVASCRIPT]                                     # Choose JavaScript approach
                                                                               # Default: importmap
                                                                               # Possible values: importmap, bun, webpack, esbuild, rollup
  -c,            [--css=CSS]                                                   # Choose CSS processor. Check https://github.com/rails/cssbundling-rails for more options
                                                                               # Possible values: tailwind, bootstrap, bulma, postcss, sass
  -B,            [--skip-bundle]                                               # Don't run bundle install
                 [--skip-decrypted-diffs]                                      # Don't configure git to show decrypted diffs of encrypted credentials

Runtime options:
  -f, [--force]                                      # Overwrite files that already exist
  -p, [--pretend], [--no-pretend], [--skip-pretend]  # Run but do not make any changes
  -q, [--quiet], [--no-quiet], [--skip-quiet]        # Suppress status output
  -s, [--skip], [--no-skip], [--skip-skip]           # Skip files that already exist

Rails options:
  -h, [--help], [--no-help], [--skip-help]           # Show this help message and quit
  -v, [--version], [--no-version], [--skip-version]  # Show Rails version number and quit

root@a51d512ab11d:/app# rails new --help
Usage:
  rails new APP_PATH [options]

Options:
                 [--skip-namespace]                                            # Skip namespace (affects only isolated engines)
                                                                               # Default: false
                 [--skip-collision-check]                                      # Skip collision check
                                                                               # Default: false
  -r,            [--ruby=PATH]                                                 # Path to the Ruby binary of your choice
                                                                               # Default: /root/.rbenv/versions/3.2.2/bin/ruby
  -n,            [--name=NAME]                                                 # Name of the app
  -m,            [--template=TEMPLATE]                                         # Path to some application template (can be a filesystem path or URL)
  -d,            [--database=DATABASE]                                         # Preconfigure for selected database
                                                                               # Default: sqlite3
                                                                               # Possible values: mysql, trilogy, postgresql, sqlite3, mariadb-mysql, mariadb-trilogy
  -G,            [--skip-git]                                                  # Skip git init, .gitignore and .gitattributes
                 [--skip-docker]                                               # Skip Dockerfile, .dockerignore and bin/docker-entrypoint
                 [--skip-keeps]                                                # Skip source control .keep files
  -M,            [--skip-action-mailer]                                        # Skip Action Mailer files
                 [--skip-action-mailbox]                                       # Skip Action Mailbox gem
                 [--skip-action-text]                                          # Skip Action Text gem
  -O,            [--skip-active-record]                                        # Skip Active Record files
                 [--skip-active-job]                                           # Skip Active Job
                 [--skip-active-storage]                                       # Skip Active Storage files
  -C,            [--skip-action-cable]                                         # Skip Action Cable files
  -A,            [--skip-asset-pipeline]                                       # Indicates when to generate skip asset pipeline
  -J, --skip-js, [--skip-javascript]                                           # Skip JavaScript files
                 [--skip-hotwire]                                              # Skip Hotwire integration
                 [--skip-jbuilder]                                             # Skip jbuilder gem
  -T,            [--skip-test]                                                 # Skip test files
                 [--skip-system-test]                                          # Skip system test files
                 [--skip-bootsnap]                                             # Skip bootsnap gem
                 [--skip-dev-gems]                                             # Skip development gems (e.g., web-console)
                 [--skip-thruster]                                             # Skip Thruster setup
                 [--skip-rubocop]                                              # Skip RuboCop setup
                 [--skip-brakeman]                                             # Skip brakeman setup
                 [--skip-ci]                                                   # Skip GitHub CI files
                 [--skip-kamal]                                                # Skip Kamal setup
                 [--skip-solid]                                                # Skip Solid Cache, Queue, and Cable setup
                 [--dev], [--no-dev], [--skip-dev]                             # Set up the application with Gemfile pointing to your Rails checkout
                 [--devcontainer], [--no-devcontainer], [--skip-devcontainer]  # Generate devcontainer files
                 [--edge], [--no-edge], [--skip-edge]                          # Set up the application with a Gemfile pointing to the 8-0-stable branch on the Rails repository
  --master,      [--main], [--no-main], [--skip-main]                          # Set up the application with Gemfile pointing to Rails repository main branch
                 [--rc=RC]                                                     # Path to file containing extra configuration options for rails command
                 [--no-rc]                                                     # Skip loading of extra configuration options from .railsrc file
                 [--api], [--no-api], [--skip-api]                             # Preconfigure smaller stack for API only apps
                                                                               # Default: false
                 [--minimal], [--no-minimal], [--skip-minimal]                 # Preconfigure a minimal rails app
  -j, --js,      [--javascript=JAVASCRIPT]                                     # Choose JavaScript approach
                                                                               # Default: importmap
                                                                               # Possible values: importmap, bun, webpack, esbuild, rollup
  -c,            [--css=CSS]                                                   # Choose CSS processor. Check https://github.com/rails/cssbundling-rails for more options
                                                                               # Possible values: tailwind, bootstrap, bulma, postcss, sass
  -B,            [--skip-bundle]                                               # Don't run bundle install
                 [--skip-decrypted-diffs]                                      # Don't configure git to show decrypted diffs of encrypted credentials

Runtime options:
  -f, [--force]                                      # Overwrite files that already exist
  -p, [--pretend], [--no-pretend], [--skip-pretend]  # Run but do not make any changes
  -q, [--quiet], [--no-quiet], [--skip-quiet]        # Suppress status output
  -s, [--skip], [--no-skip], [--skip-skip]           # Skip files that already exist

Rails options:
  -h, [--help], [--no-help], [--skip-help]           # Show this help message and quit
  -v, [--version], [--no-version], [--skip-version]  # Show Rails version number and quit

Description:
    The `rails new` command creates a new Rails application with a default
    directory structure and configuration at the path you specify.

    You can specify extra command-line arguments to be used every time
    `rails new` runs in the .railsrc configuration file in your home directory,
    or in $XDG_CONFIG_HOME/rails/railsrc if XDG_CONFIG_HOME is set.

    Note that the arguments specified in the .railsrc file don't affect the
    default values shown above in this help message.

    You can specify which version to use when creating a new rails application
    using `rails _<version>_ new`.

Examples:
    `rails new ~/Code/Ruby/weblog`

    This generates a new Rails app in ~/Code/Ruby/weblog.

    `rails _<version>_ new weblog`

    This generates a new Rails app with the provided version in ./weblog.

    `rails new weblog --api`

    This generates a new Rails app in API mode in ./weblog.

    `rails new weblog --skip-action-mailer`

    This generates a new Rails app without Action Mailer in ./weblog.
    Any part of Rails can be skipped during app generation.
```
