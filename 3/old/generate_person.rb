
def generate_person
  params = [from_file("names.txt").sample,
            "#{rand(1..28)}.#{rand(1..12)}.#{rand(1970..1995)}",
            "8" + (0..9).map { |el| el.to_s }.sample(10).join(),
            from_file("adress.txt").sample,
            "#{("a".."z").to_a.sample(rand(3..10)).join()}@mail.com",
            "#{(0..9).map { |el| el.to_s }.sample(4).join()} #{(0..9).map { |el| el.to_s }.sample(6).join()}",
            from_file("spec.txt").sample,
            rand(5)]
  if params[-1] > 0
    params.append	(from_file("companies.txt").sample(2).join())
    params.append (from_file("spec.txt").sample)
    params.append(rand(15..150) * 1000)
  end
  params
end

def from_file(filename)
  File.open(filename, "r") {|file| file.read.split("\n")}
end