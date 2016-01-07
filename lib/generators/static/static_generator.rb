class StaticGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :page_name, type: :string
  argument :path, type: :string, default: 'app/views/pages'

  def generate_static
    @file_name = page_name.parameterize('_')
    @file_path = File.join(path, @file_name + '.html')

    template "static_page.html", @file_path
    update_route
  end

  private

  def update_route
    new_route = sprintf("get '%s' => 'high_voltage/pages#show', id: '%s'", @file_name, @file_name)

    # Extract the contents of the routes file
    r = ""
    File.open("config/routes.rb") do |routes_file|
      while (line = routes_file.gets) do
        r << line
      end
    end

    # Insert in the new route entry before the last end statement
    File.open("config/routes.rb", "w") do |routes_file|
      routes_file.write(r.gsub(/^(\s+)end(\.*)$/,"\n  #{new_route}\\1end\\2"))
    end
  end
end
