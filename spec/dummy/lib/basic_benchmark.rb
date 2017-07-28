### My little tool for benchmarking code blocks
class BasicBenchmark
  def initialize(label)
    time = Time.now
    puts "--> #{label}"
    yield
    puts "======= Completed in #{(Time.now - time)} s ======="
  end
end
