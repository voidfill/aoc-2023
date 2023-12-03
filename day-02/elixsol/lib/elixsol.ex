defmodule Elixsol do
	use Application

  def one(input) do
    numRed = 12
    numGreen = 13
    numBlue = 14

    Enum.at(
      Enum.reduce(String.split(input, "\n"), [1, 0], fn line, acc ->
        valid =
          Enum.reduce(
            String.split(Enum.at(String.split(line, ": "), 1), [", ", "; "]),
            true,
            fn draw, valid ->
              if !valid do
                false
              else
                spl = String.split(draw, " ")
                x = String.to_integer(Enum.at(spl, 0))
                y = Enum.at(spl, 1)

                if (y == "red" && x > numRed) || (y == "green" && x > numGreen) ||
                     (y == "blue" && x > numBlue) do
                  false
                else
                  true
                end
              end
            end
          )

        if valid do
          [Enum.at(acc, 0, 0) + 1, Enum.at(acc, 1, 0) + Enum.at(acc, 0, 0)]
        else
          [Enum.at(acc, 0, 0) + 1, Enum.at(acc, 1, 0)]
        end
      end),
      1,
      0
    )
  end

  def two(input) do
    Enum.reduce(String.split(input, "\n"), 0, fn line, acc ->
      vals =
        Enum.reduce(
          String.split(Enum.at(String.split(line, ": "), 1), [", ", "; "]),
          [0, 0, 0],
          fn draw, acc ->
            spl = String.split(draw, " ")
            x = String.to_integer(Enum.at(spl, 0))
            y = Enum.at(spl, 1)

            r =
              if y == "red" && x > Enum.at(acc, 0) do
                x
              else
                Enum.at(acc, 0)
              end

            g =
              if y == "green" && x > Enum.at(acc, 1) do
                x
              else
                Enum.at(acc, 1)
              end

            b =
              if y == "blue" && x > Enum.at(acc, 2) do
                x
              else
                Enum.at(acc, 2)
              end

            [r, g, b]
          end
        )

      acc + Enum.at(vals, 0) * Enum.at(vals, 1) * Enum.at(vals, 2)
    end)
  end

	def start(_type, _args) do
    {ok, input} = File.read("../input.txt")
		if !ok do
			raise "Could not read file"
		end

		IO.puts "Part 1: #{one(input)}"
		IO.puts "Part 2: #{two(input)}"
  end

end
