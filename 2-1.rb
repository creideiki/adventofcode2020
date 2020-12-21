num_valid = 0

File.readlines('2.input').each do |row|
  count, allowed, pass = row.split(' ')
  min = count.split('-').first.to_i
  max = count.split('-').last.to_i
  c = allowed[0]
  current_count = 0
  pass.split('').each do |x|
    if x == c then
      current_count += 1
    end
  end
  if current_count >= min and current_count <= max then
    num_valid += 1
  end
end

print num_valid, "\n"
