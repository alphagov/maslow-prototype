# Maslow prototype

This is a prototype of how Maslow could look. This was a precursor to the actual [Need API](https://github.com/alphagov/govuk_need_api) and [Maslow](https://github.com/alphagov/maslow) projects.

## Getting started

Install dependencies and import the organisations list:

    bundle install
    bundle exec rake organisations:import
    bundle exec unicorn -p 5000

Visit <http://localhost:5000/> in your browser to start adding needs.


