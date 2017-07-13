require 'bunny'

pub_count = Integer(ARGV[0])

msg_size = Integer(ARGV[1])
msg = Random.new.bytes(msg_size)

b = Bunny.new.start
ch = b.create_channel
q = ch.queue("lazy_#{msg_size}", durable: true)
puts q.name
pub_count.times do
  q.publish msg
end
