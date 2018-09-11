require 'socket'
server  = TCPServer.new('0.0.0.0', 8080)

class Response
  def initialize(code:, data: "")
     @response =
         "HTTP/1.1 #{code}\r\n" +
         "Content-Length: #{data.size}\r\n" +
         "\r\n" +
         "#{data}\r\n"
  end

  def send(client)
      client.write(@response)
  end
end

def parse(request)
  method, path = request.lines[0].split
  {
    path: path,
    method: method
  }
end


loop {
        client  = server.accept
        request = client.readpartial(2048)
        parsed = parse(request)
        resp = Response.new(code: 200, data: "path: #{parsed.fetch(:path)}")
        resp.send(client)
        client.close
}