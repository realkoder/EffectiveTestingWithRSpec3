module API
  class App

    def initialize(service)
      @service = service
    end

    def test_me
      @service.call
    end

  end
end
