module RequestSpecHelper
    def json_body
        @json_body ||= JSON.parse(response.body)
    end
end