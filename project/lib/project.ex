#Final Project
# Transformar datos de un archivo CSV (sin morir en el intento)
#
#Ángeles Hernández
#Yair Camacho
#2022-07-28

defmodule Project do

  @doc """
  Takes a csv file and calculates the total sales for each region

  ## Parameters
    - in_filename: String with the name of the file with the data to calculate
    - out_filename: String with the name of the file with the computed data
  """
  def main(in_filename, out_filename) do
    # Read the file
    data = read_file(in_filename)
    # Remove header
    [_header | raw_data] = data
    process_row(raw_data, 0, 0, 0)
    |> format_table()
    # Write the new file
    |> write_csv(out_filename)
  end

  defp read_file(in_filename) do
    in_filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, ","))
  end

  defp process_row([], total_1, total_2, total_3), do: [Float.ceil(total_1, 2), Float.ceil(total_2, 2), Float.ceil(total_3, 2)]
  defp process_row([row | tail], total_1, total_2, total_3) do
    [_store, region_str, _item, unitprice_str, quantity_str, _month] = row
    region_int = String.to_integer(region_str)
    unitprice_temp = String.trim(unitprice_str)
    unitprice_flt = String.to_float(unitprice_temp)
    quantity_int = String.to_integer(quantity_str)
    [subtotal_1, subtotal_2, subtotal_3] = compute_data([region_int, unitprice_flt, quantity_int], total_1, total_2, total_3)
    process_row(tail, subtotal_1, subtotal_2, subtotal_3)
  end

  defp compute_data([region, unitprice, quantity], total_1, total_2, total_3) do
    case region do
      1 -> [(total_1 + (unitprice * quantity)), total_2, total_3]
      2 -> [total_1, (total_2 + (unitprice * quantity)), total_3]
      3 -> [total_1, total_2, (total_3 + (unitprice * quantity))]
    end
  end

  defp format_table([total_1, total_2, total_3]) do
    [
      ["1",Float.to_string(total_1)],
      ["2",Float.to_string(total_2)],
      ["3",Float.to_string(total_3)]
    ]
  end

  @doc """
  Writes the computed data into a new file

  ## Parameters
    - data: List with the rows which are going to
  """
  defp write_csv(data, out_filename) do
    cvs_data =
      # Add new header
      ["Region", "Ventas Totales"]
      |> Kernel.then(&[&1 | data])
      |> Enum.map(&Enum.join(&1, ","))
      |> Enum.join("\n")
      # Write the data into a new file
      out_filename
      |> Path.expand(__DIR__)
      |> File.write(cvs_data)
  end
end
