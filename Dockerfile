FROM ruby
EXPOSE 8080
COPY rubyserv.rb /opt/
CMD ruby /opt/rubyserv.rb