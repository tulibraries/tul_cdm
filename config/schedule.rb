# Generate site map at the top of each our
# [TODO] Remove no_ping in production
# [TODO] Set to longer interval in production

every :hour do
  rake "sitemap:refresh:no_ping"
end

