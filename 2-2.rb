num_valid = 0

File.readlines('2.input').each do |row|
  positions, allowed, pass = row.split(' ')
  pos1 = positions.split('-').first.to_i - 1
  pos2 = positions.split('-').last.to_i - 1
  c = allowed[0]
  if (pass[pos1] == c or pass[pos2] == c) and
      not (pass[pos1] == c and pass[pos2] == c) then
    num_valid += 1
  end
end

print("#{num_valid}\n")

