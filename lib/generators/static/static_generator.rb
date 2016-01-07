class StaticGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :page_name, type: :string
  argument :path, type: :string, default: 'app/views/pages'

  def generate_static
    template "static_page.html", filename
  end

  private

  def filename
    filename = page_name.parameterize('_') + '.html'
    filepath = path
    File.join(filepath, filename)
  end
end
