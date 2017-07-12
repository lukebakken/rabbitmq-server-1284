require 'bunny'

msg_size = Integer(ARGV[0])
msg = Random.new.bytes(msg_size)

b = Bunny.new.start
ch = b.create_channel
q = ch.queue("lazy_#{msg_size}", durable: true)
puts q.name
4096.times do
  q.publish msg
end
