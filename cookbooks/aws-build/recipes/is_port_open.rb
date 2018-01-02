require 'socket'
require 'timeout'

@ip_address = '54.236.253.24'
@port = '22'
def is_port_open?(ip, port)
  begin
    Timeout::timeout(1) do
      begin
        require 'socket'
        require 'timeout'
        s = TCPSocket.new(ip, port)
        s.close
        return true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        return false  
      end
    end
  rescue Timeout::Error
  end
  return false
end


#host = ARGV[0].split(":")[0]
#ip = ARGV[0].split(":")[1].to_i

puts is_port_open?(@ip_address,@port)
