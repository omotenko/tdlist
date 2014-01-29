require 'json'

module ServerSide
  class SSE
    def initialize io
      @io = io
    end

    def write object
      @io.write object
    end

    def close
      @io.close
    end
  end
end