require 'bunny'
b = Bunny.new.start
ch = b.create_channel
1.times do |i|
  q = ch.queue("x_queue_mode_lazy_#{i}",
               durable: true,
               arguments: { 'x-queue-mode' => 'lazy' })
  puts q.name
  16384.times do
    q.publish "aaaa"
  end
end
