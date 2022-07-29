#Final Project
# Transformar datos de un archivo CSV (sin morir en el intento)
#
#Ángeles Hernández
#Yair Camacho
#2022-07-28

defmodule Project do

  #Read the file
  def main(in_filename, out_filename) do
    new_text = in_filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1,","))
    |> Project.compute_data(0, 0, 0)
    #|> Project.process_row(0, 0, 0)
    #File.write(out_filename, new_text)
    #|> store_csv(out_filename)
  end

  #Read file and get the necessary data (region, quantity, unitprice)
  def process_row([row, tail], total1, total2, total3) do
   # [head , tail] = row
    [store, region, item, unitprice, quantity, month] = String.split(row, ",")
    regioni = String.to_integer(region)
    unitpricei = String.to_integer(unitprice)
    quantityi = String.to_integer(quantity)
    case regioni do
     1 -> total1 = total1 + (unitpricei * quantityi)
     2 -> total2 = total2 + (unitpricei * quantityi)
     3 -> total3 = total3 + (unitpricei * quantityi)
    end

    process_row(tail, total1, total2, total3)
    total1n = Integer.to_string(total1)
    total2n = Integer.to_string(total2)
    total3n = Integer.to_string(total3)

    Enum.join([total1n, total2n, total3n], ",")


  end

  def compute_data([row, tail], total1, total2, total3) do
    tail = nil
    [store, region, item, unitprice, quantity, month] = String.split(row, ",")
    |> IO.inspect()
  end


end
