FROM ubuntu:16.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get install mysql-client -y \
  g++ gcc apache2 libmysqlclient20 \
  git-core openssl libreadline6 libreadline6-dev \
  zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev \
  sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev \
  ncurses-dev automake libtool bison subversion \
  pkg-config unzip pyflakes ruby ruby-dev default-jdk \
  libmysqld-dev mercurial python-setuptools python-dev python3-numpy \
  build-essential libpq-dev nodejs curl tzdata && rm -rf /var/lib/apt/lists/*
WORKDIR /
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
ENV RUBY_VERSION=2.3.4
ENV TZ=\"Asia/Bangkok\"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN curl -k -L https://get.rvm.io | bash -s stable
RUN /bin/bash /etc/profile.d/rvm.sh
RUN /bin/bash -l -c "rvm install $RUBY_VERSION"
RUN /bin/bash -l -c "rvm use $RUBY_VERSION"
RUN mkdir cafe_grader
WORKDIR /cafe_grader
ADD web /cafe_grader/web
RUN cp web/config/application.rb.SAMPLE web/config/application.rb
RUN cp web/config/initializers/cafe_grader_config.rb.SAMPLE web/config/initializers/cafe_grader_config.rb
RUN export timezone=`cat /etc/timezone` && export replace="s!'UTC'!$timezone!g" && echo $replace && sed -i $replace web/config/application.rb
WORKDIR /cafe_grader/web

RUN echo "Object.instance_eval{remove_const :GRADER_ROOT_DIR}" >> config/initializers/cafe_grader_config.rb 
RUN echo "Object.instance_eval{remove_const :GRADING_RESULT_DIR}" >> config/initializers/cafe_grader_config.rb
RUN echo "GRADER_ROOT_DIR = '/cafe_grader/judge'" >> config/initializers/cafe_grader_config.rb
RUN echo "GRADING_RESULT_DIR = '/cafe_grader/judge/result'" >> config/initializers/cafe_grader_config.rb

RUN gem install bundler --version '< 2.0'
RUN bundle install

RUN mkdir /cafe_grader/judge
WORKDIR /cafe_grader/judge
ADD scripts /cafe_grader/judge/scripts
RUN mkdir raw
RUN mkdir ev-exam
RUN mkdir ev
RUN mkdir result
RUN mkdir log

RUN cp scripts/config/env_exam.rb.SAMPLE scripts/config/env_exam.rb
RUN cp scripts/config/env_grading.rb.SAMPLE scripts/config/env_grading.rb

RUN echo "RAILS_ROOT = '/cafe_grader/web'" > scripts/config/environment.rb
RUN echo "GRADER_ROOT = '/cafe_grader/judge/scripts'" >> scripts/config/environment.rb
RUN echo "require File.join(File.dirname(__FILE__),'../lib/boot')" >> scripts/config/environment.rb
RUN echo "require File.dirname(__FILE__) + \"/env_#{GRADER_ENV}.rb\"" >> scripts/config/environment.rb

RUN gcc -std=c99 -o scripts/std-script/box scripts/std-script/box64-new.c

WORKDIR /cafe_grader/web
ADD . /cafe_grader
CMD /bin/bash /cafe_grader/wait-for-mysql.sh
