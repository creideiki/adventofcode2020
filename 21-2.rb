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

actual_allergens = {}

until possible_allergens.empty?
  definitive = possible_allergens.select do |allergen, possible_ingredients|
    possible_ingredients.size == 1
  end
  definitive.each do |allergen, ingredient|
    actual_allergens[allergen] = ingredient[0]
    possible_allergens.each do |a, possible_ingredients|
      if possible_ingredients.include? ingredient[0]
        possible_allergens[a] = possible_allergens[a].reject { |i| i == ingredient[0] }
      end
    end
    possible_allergens.delete allergen
  end
end

print actual_allergens.to_a.sort { |a, b| a[0] <=> b[0] }.map { |x| x[1] }.join ','
print "\n"
