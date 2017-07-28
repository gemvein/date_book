# Message Train module
module DateBook
  VERSION = File.read(File.expand_path('../../../VERSION', __FILE__))

  def self.version_string
    "DateBook version #{DateBook::VERSION}"
  end
end
