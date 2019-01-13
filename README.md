# huginn-docker

This project contains a production-ready
[Huginn](https://github.com/cantino/huginn) deployment with Docker.

The following images are built from this project:

* `hackedu/huginn`
* `hackedu/huginn-web`
* `hackedu/huginn-jobs`

## Usage

Run database migrations (the host DB must by MySQL compatible):

    docker run --rm \
      -e "RAILS_ENV=production" \
      -e "DATABASE_NAME=TODO" \
      -e "DATABASE_USERNAME=TODO" \
      -e "DATABASE_PASSWORD=TODO" \
      -e "DATABASE_HOST=todo.example.com" \
      -e "DATABASE_PORT=TODO" \
      -e "DATABASE_ENCODING=utf8mb4" \
      -e "INVITATION_CODE=my-invitation-code" \
      hackedu/huginn rake db:migrate

Seed the database (optional):

    docker run --rm \
      -e "RAILS_ENV=production" \
      -e "DATABASE_NAME=TODO" \
      -e "DATABASE_USERNAME=TODO" \
      -e "DATABASE_PASSWORD=TODO" \
      -e "DATABASE_HOST=todo.example.com" \
      -e "DATABASE_PORT=TODO" \
      -e "DATABASE_ENCODING=utf8mb4" \
      -e "SEED_USERNAME=TODO" \
      -e "SEED_PASSWORD=TODO" \
      hackedu/huginn rake db:seed

Launch a web instance:

    docker run -d \
      -e "RAILS_ENV=production" \
      -e "APP_SECRET_TOKEN=TODO (generate with rake secret)" \
      -e "DATABASE_NAME=TODO" \
      -e "DATABASE_USERNAME=TODO" \
      -e "DATABASE_PASSWORD=TODO" \
      -e "DATABASE_HOST=TODO" \
      -e "DATABASE_PORT=TODO" \
      -e "DATABASE_ENCODING=utf8mb4" \
      -p 3000:3000 \
      hackedu/huginn-web

Launch a job worker instance:

    docker run -d \
      -e "RAILS_ENV=production" \
      -e "APP_SECRET_TOKEN=TODO (generate with rake secret)" \
      -e "DATABASE_NAME=TODO" \
      -e "DATABASE_USERNAME=TODO" \
      -e "DATABASE_PASSWORD=TODO" \
      -e "DATABASE_HOST=TODO" \
      -e "DATABASE_PORT=TODO" \
      -e "DATABASE_ENCODING=utf8mb4" \
      -p 3000:3000 \
      hackedu/huginn-jobs

You can override any environment variables when launching Huginn containers.
For a list, see the
[.env.example](https://github.com/cantino/huginn/blob/master/.env.example)
file. Do note that there are additional required variables in the list, you'll
want to add them when deploying.

### Building

Build all images:

    $ make build

Push all images:

    $ make push

The `push` target depends on the `build` target, so if you want to build and
push, you only need to run `make push`.

Note: If you want to change the name of the images, you need to change both the
Makefile and the web and jobs Dockerfiles.

## License

The MIT License (MIT)

Copyright (c) 2019 Hack Club

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
