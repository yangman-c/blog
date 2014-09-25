require 'benchmark'

Benchmark.bm do |x|
 str1, str2 = "",""
 x.report("op:+=") do
   3000000.times do
     str1 += "foobar"
   end
 end

 x.report("op:<<") do
   3000000.times do
     str2 << "foobar"
   end
 end
end
