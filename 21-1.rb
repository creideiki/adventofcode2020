#!/usr/bin/env ruby

specs = File.read('21.input').lines.map &:strip

foods = []
possible_allergens = {}

specs.each do |spec|
  ingredients, allergens = spec.split '('
  ingredients = ingredients.split
  allergens = allergens.split.map { |a| a.delete ',)' }.reject { |a| a == 'contains' }
  allergens.each do |a|
    possible_allergens[a] = []
  end
  foods.push [ingredients, allergens]
end

possible_allergens.each_key do |allergen|
  foods_containing_allergen = foods.select { |f| f[1].include? allergen }.map &:first
  possible_allergens[allergen] = foods_containing_allergen.reduce { |memo, f| memo.intersection f }
end

safe = {}

foods.each do |food|
  ingredients = food[0]
  ingredients.each do |ingredient|
    safe[ingredient] = true unless possible_allergens.any? { |k, v| v.include? ingredient }
  end
end

count = 0
foods.each do |f|
  count += f[0].count { |ingredient| safe.include? ingredient }
end

print count, "\n"
