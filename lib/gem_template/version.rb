# Message Train module
module GemTemplate
  VERSION = File.read(File.expand_path('../../../VERSION', __FILE__))

  def self.version_string
    "GemTemplate version #{GemTemplate::VERSION}"
  end
end
