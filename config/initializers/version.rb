module MyApp
  class Version
    VERSION = ENV['APP_VERSION'] || '1.0.0'

    class << self
      def to_s
        VERSION
      end

      def from_git
        `git describe --tags`.chomp rescue VERSION
      end
    end
  end
end
